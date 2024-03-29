class PurchasesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @purchases = Purchase.order(created_at: :desc)

    if params[:shipped].present? && params[:shipped] == "true"
      @purchases = @purchases.where(status: "CAPTURED")
    else
      if params[:proof].present? && params[:proof] == "false"
        @purchases = @purchases.where(status: "AUTHORIZED_NO_PROOF")
      else
        @purchases = @purchases.where(status: "AUTHORIZED_PROOF")
      end
    end

    @purchases = @purchases.paginate(page: params[:page], per_page: 12)
  end

  def checkout
    if !params["_method"].present? && params[:submitButton] == "Complete Purchase"
      card_number = params[:card_number].delete(' ')
      if !card_number.scan(/\D/).empty? || card_number.length != 16
        redirect_back(fallback_location: checkout_path(post_id: params[:post_id]), alert: "Error - The Card Number needs to have exactly 16 digits.")
        return
      end

      zip_code = params[:zip_code]
      if !zip_code.scan(/\D/).empty?
        redirect_back(fallback_location: checkout_path(post_id: params[:post_id]), alert: "Error - The Zip Code should contain only digits.")
        return
      end

      cvv = params[:card_cvc]
      if !cvv.scan(/\D/).empty?
        redirect_back(fallback_location: checkout_path(post_id: params[:post_id]), alert: "Error - The CVV should contain only digits.")
        return
      end

      card_year = params[:card_year].to_i
      card_month = params[:card_month].to_i
      if card_year == Time.now.year % 100 && card_month < Time.now.month
        redirect_back(fallback_location: checkout_path(post_id: params[:post_id]), alert: "Error - The Card is expired.")
        return
      end

      county = Location.where(short: params[:county]).first.name

      process_payment(params[:post_id], card_number, cvv, card_year, card_month, params[:card_first_name], params[:card_last_name], params[:full_name], params[:address],
        params[:county], params[:city], params[:zip_code])
    else
      @post = Post.find(params[:post_id])
      
      if @post.sale_price.nil? && current_user.discount.present?
        @reduced_price = @post.price - ((current_user.discount * @post.price) / 100)
      elsif @post.sale_price.present?
        @reduced_price = @post.sale_price
      else
        @reduced_price = @post.price
      end
      
      if current_user.phone.nil?
        redirect_back(fallback_location: posts_path, alert: "Error - Please introduce your Phone Number (see your Profile Page) before trying to buy a bicycle.")
        return
      end
    end
  end

  def process_payment(post_id, card_number, card_cvv, card_year, card_month, card_first_name, card_last_name, full_name, address, county, city, zip_code)
    ActiveMerchant::Billing::Base.mode = :test

    Post.transaction do
      post = Post.find(post_id)
      post.lock!  # pessimistic locking
      
      if !post.sold
        gateway = ActiveMerchant::Billing::PaypalGateway.new(
          login: ENV['PAYPAL_LOGIN'],
          password: ENV['PAYPAL_PASSWORD'],
          signature: ENV['PAYPAL_SIGNATURE']
        )

        # credit_card = ActiveMerchant::Billing::CreditCard.new(
        #   brand: "visa",
        #   number: card_number,
        #   verification_value: card_cvv,
        #   month: card_month,
        #   year: card_year,
        #   first_name: card_first_name,
        #   last_name: card_last_name
        # )

        credit_card = ActiveMerchant::Billing::CreditCard.new(
          brand: "visa",
          number: ENV['PAYPAL_TEST_CARD_NUMBER'],
          verification_value: "123",
          month: 3,
          year: 2028,
          first_name: "John",
          last_name: "Doe"
        )

        if credit_card.valid?
          price = post.sale_price.present? ? post.sale_price : post.price
          if current_user.discount.present?
            price = price - ((current_user.discount * price) / 100)
          end
          price = price * 100

          response = gateway.authorize(price, credit_card, ip: "127.0.0.1")   # just authorize the payment, don't get the money (gateway.purchase to do both authorize and capture)
          if response.success?
            post.sold = true
            post.sold_date = Time.now
            post.buyer_id = current_user.id
            post.is_active = -2
            
            shipping_details = {
              full_name: full_name,
              address: address,
              county: county,
              city: city,
              zip_code: zip_code
            }
            payment_details = {
              authorization_code: response.authorization,
              amount: price
            }
            Purchase.create(seller_id: post.user_id, buyer_id: current_user.id, post_id: post.id, amount: price / 100, status: "AUTHORIZED_NO_PROOF", shipping_details: shipping_details,
              payment_details: payment_details)

            Notification.create(notification_type: "ship_bike", notified_id: post.user_id, message: "#{post.name} was bought. Ship it in 2 days")

            user = post.user
            if user.sms_opt_in
              phone = user.phone
              message = "BikeFiesta - Your post #{post.name} was bought. You have 2 days to ship it and upload the proof. Shipping details - Name:
                #{full_name}, Address: #{address}, County: #{county}, City: #{city}, Zip Code: #{zip_code}"
              AsyncSendSmsToUser.perform_async(phone, message)
            end

            current_user.discount = nil
            current_user.save(validate: false)
            
            post.save!
            redirect_to posts_path, alert: "Your payment was authorized successfully. Your money will leave your account once the seller will ship the bicycle, he has 2 days to do it."
          else
            redirect_back(fallback_location: checkout_path(post_id: post_id), alert: "Error - #{response.message}.")
            return
          end
        else
          redirect_back(fallback_location: checkout_path(post_id: post_id), alert: "Error - The credit card is not valid: #{credit_card.errors.full_messages.join('. ')}.")
          return
        end
      else
        redirect_to posts_path, alert: "Error - Sorry, this bike was just bought by someone else."
        return
      end
    end
  end

  def mark_as_shipped
    ActiveMerchant::Billing::Base.mode = :test

    purchase = Purchase.find(params[:id])

    gateway = ActiveMerchant::Billing::PaypalGateway.new(
      login: ENV['PAYPAL_LOGIN'],
      password: ENV['PAYPAL_PASSWORD'],
      signature: ENV['PAYPAL_SIGNATURE']
    )

    response = gateway.capture(purchase.amount * 100, purchase.payment_details[:authorization_code])
    if response.success?
      Notification.create(notification_type: "shipped_purchase", notified_id: purchase.seller_id, message: "The proof for #{purchase.post.name} was accepted. You will receive the money in maximum 5 days")
      Notification.create(notification_type: "shipped_purchase", notified_id: purchase.buyer_id, message: "The bike #{purchase.post.name} was shipped. You will receive it in 2-3 days")

      seller = purchase.seller
      buyer = purchase.buyer
      seller_phone = seller.phone
      buyer_phone = buyer.phone
      seller_message = "BikeFiesta - The bike #{purchase.post.name} was shipped. You will receive it in 2-3 days."
      buyer_message = "BikeFiesta - The bike #{purchase.post.name} was shipped. You will receive it in 2-3 days. Please contact an admin in maximum 5 days if anything bad happens"
      
      if seller.sms_opt_in
        AsyncSendSmsToUser.perform_async(seller_phone, seller_message)
      end
      if buyer.sms_opt_in
        AsyncSendSmsToUser.perform_async(buyer_phone, buyer_message)
      end

      purchase.status = "CAPTURED"
      purchase.save

      post = purchase.post
      post.is_active = -3
      post.shipped = true
      post.shipped_date = Time.now
      post.save

      Notification.create(notification_type: "invoice", post_id: purchase.post_id, notified_id: purchase.seller_id, message: "Download your invoice for ")
      Notification.create(notification_type: "invoice", post_id: purchase.post_id, notified_id: purchase.buyer_id, message: "Download your invoice for ")

      AsyncCheckForDiscount.perform_async(purchase.seller_id, "seller")
      AsyncCheckForDiscount.perform_async(purchase.buyer_id, "buyer")

      redirect_back(fallback_location: purchases_path, alert: "Purchase marked as shipped successfully.")
    else
      redirect_back(fallback_location: purchases_path, alert: "Error - #{response.message}.")
    end
  end

  def cancel_purchase
    ActiveMerchant::Billing::Base.mode = :test
    success = false

    purchase = Purchase.find(params[:id])

    gateway = ActiveMerchant::Billing::PaypalGateway.new(
      login: ENV['PAYPAL_LOGIN'],
      password: ENV['PAYPAL_PASSWORD'],
      signature: ENV['PAYPAL_SIGNATURE']
    )

    void_method_response = gateway.void(purchase.payment_details[:authorization_code])
    if !void_method_response.success?
      refund_method_response = gateway.refund(purchase.amount * 100, purchase.payment_details[:authorization_code])
      if refund_method_response.success?
        success = true
      else
        redirect_back(fallback_location: purchases_path, alert: "Error - #{refund_method_response.message}.")
        return
      end
    else
      success = true
    end

    if success
      Notification.create(notification_type: "cancel_purchase", notified_id: purchase.seller_id, message: "The shipping proof for #{purchase.post.name} was not okay. The purchase was cancelled")
      Notification.create(notification_type: "cancel_purchase", notified_id: purchase.buyer_id, message: "The shipping proof for #{purchase.post.name} was not okay. The purchase was cancelled")

      seller = purchase.seller
      buyer = purchase.buyer
      seller_phone = seller.phone
      buyer_phone = buyer.phone
      message = "BikeFiesta - The shipping proof for #{purchase.post.name} was not okay. The purchase was cancelled."

      if seller.sms_opt_in
        AsyncSendSmsToUser.perform_async(seller_phone, message)
      end
      if buyer.sms_opt_in
        AsyncSendSmsToUser.perform_async(buyer_phone, message)
      end

      post.sold_date = nil
      post.sold = false
      post.buyer_id = nil
      post.save

      purchase.delete

      redirect_back(fallback_location: purchases_path, alert: "Purchase canceled successfully.")
    end
  end

  def mark_on_hold
    purchase = Purchase.find(params[:id])
    purchase.on_hold = true
    purchase.save
    redirect_back(fallback_location: purchases_path, alert: "Purchase marked on hold successfully.")
  end

  def mark_off_hold
    purchase = Purchase.find(params[:id])
    purchase.on_hold = false
    purchase.save
    redirect_back(fallback_location: purchases_path, alert: "Purchase marked off hold successfully.")
  end

  def show
    @purchase = Purchase.find(params[:id])

    if @purchase.status != "CAPTURED" || !(current_user.is_admin? || @purchase.seller_id == current_user.id || @purchase.buyer_id == current_user.id)
      redirect_back(fallback_location: posts_path, alert: "Error - You are not allowed to see this invoice.")
      return
    end
    
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Purchase ##{@purchase.id} - #{@purchase.seller.full_name} - #{@purchase.buyer.full_name}",
        page_size: 'A4',
        template: "purchases/show.html.erb",
        layout: "pdf.html",
        orientation: "Landscape",
        lowquality: true,
        zoom: 1,
        dpi: 75
      end
    end
  end
end
