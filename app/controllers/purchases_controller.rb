class PurchasesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @purchases = Purchase.order(created_at: :desc)
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
    end
  end

  def process_payment(post_id, card_number, card_cvv, card_year, card_month, card_first_name, card_last_name, full_name, address, county, city, zip_code)
    ActiveMerchant::Billing::Base.mode = :test

    post = Post.find(post_id)

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
      price = 0
      if post.sale_price.present?
        price = post.sale_price
      else
        price = post.price
      end
      price = price * 100

      response = gateway.authorize(price, credit_card, ip: "127.0.0.1")   # just authorize the payment, don't get the money (gateway.purchase to do both authorize and capture)
      if response.success?
        post.sold = true
        post.sold_date = Time.now     #TODO if after 3 days it was not shipped, then make these false and nil
        post.buyer_id = current_user.id
        post.save
        # TODO after the bike was shipped set is_active = -2
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

        phone = post.user.phone
        message = "BikeFiesta - Your post #{post.name} was bought. You have 2 days to ship it and upload the proof. Shipping details - Name:
          #{full_name}, Address: #{address}, County: #{county}, City: #{city}, Zip Code: #{zip_code}"
        Marketing.send_sms(phone, message)
        
        redirect_to posts_path, alert: "Your payment was authorized. Your money will leave your account once the seller will ship the bicycle, he has 2 days to do it."
      else
        redirect_back(fallback_location: checkout_path(post_id: post_id), alert: "Error - #{response.message}.")
        return
      end
    else
      redirect_back(fallback_location: checkout_path(post_id: post_id), alert: "Error - The credit card is not valid: #{credit_card.errors.full_messages.join('. ')}.")
      return
    end
  end

  # gateway.capture(price, response.authorization) #TODO after the bike was shipped we capture the payment
  # gateway.void(response.authorization)  #TODO if after 3 days the bike was not shipped we unblock the money
  # gateway.credit(1000, response.authorization)  #TODO if .void fails try this
  # transfer = gateway.transfer(
  #   1000, 'sb-3orv825105929@personal.example.com', :subject => "The money I owe you", :note => "Sorry it's so late" #TODO after we capture the payment we keep 10% to us and send the rest to the seller
  # )
end
