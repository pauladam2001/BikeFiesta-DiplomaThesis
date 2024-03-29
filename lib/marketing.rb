module Marketing
  
  # Called every time a post is created (async)
  # This function checks if there is a bike photo in the images associated with a post and after that it makes the post
  # active and sends an SMS for the followers of the user
  def self.check_images_for_post(post_id)
    post = Post.find(post_id)
    link = 'http://localhost:8000/api/predict?token=24apa2001&cloudinary_url='
    is_bicycle = false

    post.assets.each do |asset|
      begin
        asset_link = link + asset.image.url.split('http://res.cloudinary.com/')[1]
        h = HTTParty.post(asset_link, timeout: 30)
      rescue Exception => e
        puts e
        next
      end
      
      h.each do |response|
        if (response["class"].include?("bike") || response["class"].include?("bicycle") || response["class"].include?("cycle")) || response["confidence"] >= 50.0
          asset.is_bicycle = true
          asset.save
          is_bicycle = true
          break
        end
      end

      if is_bicycle
        break
      end
    end

    if is_bicycle
      post.is_active = 1
      Notification.create(notification_type: "post_status", notified_id: post.user_id, message: "One of your posts has just been approved")
      AsyncSendSmsToFollowers.perform_async(post.user_id, post.name)
    else
      post.is_active = -1
      Notification.create(notification_type: "post_status", notified_id: post.user_id, message: "One of your posts was not approved")
    end

    post.save(validate: false)
  end

  # Called hourly
  # Delete any posts from db that have no associated images and are created more than 30 miutes ago
  def self.check_posts_without_assets
    Post.find_each do |post|
      if post.assets.count < 0 && post.created_at < 30.minutes.ago
        Post.destroy
      end
    end
  end

  # Called daily
  # Mark random posts for sale
  def self.mark_posts_on_sale
    random_offset = Random.rand(Post.count)
    random_posts = Post.offset(random_offset).first(Post.count / 3)
    random_posts.each do |post|
      if (post.sale_price.present? && post.sale_price_expiration.present? && post.created_at < 7.days.ago) || post.is_active != 1
        next
      end

      sale_percentage = Random.rand(10)
      sale_price = post.price - ((sale_percentage * post.price) / 100)

      post.sale_percentage = sale_percentage
      post.sale_price = sale_price
      post.sale_price_expiration = Time.now + 1.day

      post.save(validate: false)
    end
  end

  # Called daily
  # Unmark the posts from sale
  def self.unmark_posts_on_sale
    Post.where.not(is_active: 1).where("sale_price_expiration <= ?", Time.now).where.not(sale_price: nil).find_each do |post|
      post.sale_price = nil
      post.sale_price_expiration = nil
      post.sale_percentage = nil

      post.save(validate: false)
    end
  end

  # Called every 30 minutes
  # Reset codes for 2FA
  def self.reset_user_codes
    User.where("code_expiration_date <= ?", Time.now).find_each do |user|
      user.code = nil
      user.code_expiration_date = nil

      user.save(validate: false)
    end
  end

  # Used to send SMS to specific users
  def self.send_sms(phone, message)
    require 'twilio-ruby'

    if phone.present? && message.present?
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      client = Twilio::REST::Client.new(account_sid, auth_token)

      from = ENV['TWILIO_NUMBER']
      # to = phone
      to = ENV['TWILIO_TRIAL_NUMBER']
      
      client.messages.create(
        from: from,
        to: to,
        body: message
      )
    end
  end

  # Called daily
  # Send notification to buyer if he bought the bike more than 5 days ago
  def self.send_notification_to_buyers
    Post.where(leave_review_notification_sent: false).where("shipped_date <= ?", 5.days.ago).find_each do |post|
      Notification.create(notification_type: "review", post_id: post.id, notified_id: post.buyer_id, message: "Leave a review for ")
      
      post.leave_review_notification_sent = true
      post.save
    end
  end

  # Called daily
  # Calculate user's rating based on reviews
  def self.calculate_users_rating
    User.where(role: "normal", archived: false).find_each do |user|
      rating = 0.0
      count = 0
      
      user.reviews.each do |review|
        rating += review.grade
        count += 1
      end

      user.rating = (rating / count).nan? ? 0.0 : (rating / count)
      user.save(validate: false)
    end
  end

  # Called every time a post is banned (async)
  # It goes through all the reports that were related to the banned post, marks them as solved and sends messages to all
  # users that reported the post
  def self.mark_post_reports_as_solved(post_id)
    message = "BikeFiesta - One of the posts that you reported was banned. Thank you!"

    Report.where(post_id: post_id).find_each do |report|
      user = report.user
      if user.sms_opt_in
        phone = user&.phone
        AsyncSendSmsToUser.perform_async(phone, message)
      end

      Notification.create(notification_type: "banned_post", notified_id: report.user_id, message: "One of the posts that you reported was banned")

      report.solved = true
      report.save
    end
  end

  # Called hourly
  # It goes thorugh the posts that are sold but not shipped and checks if they were bought more than 3 days ago. If yes
  # and the seller did not update the proof, then we cancel the purchase
  # PayPal recommends to capture payments within 3 days of the original authorization
  def self.check_posts_to_be_shipped
    ActiveMerchant::Billing::Base.mode = :test

    gateway = ActiveMerchant::Billing::PaypalGateway.new(
      login: ENV['PAYPAL_LOGIN'],
      password: ENV['PAYPAL_PASSWORD'],
      signature: ENV['PAYPAL_SIGNATURE']
    )

    Post.where(sold: true, shipped: false).where("sold_date <= ?", 3.days.ago).find_each do |post|
      purchase = post.purchase
      success = false

      if !purchase.proof.attached?
        void_method_response = gateway.void(purchase.payment_details[:authorization_code])
        if !void_method_response.success?
          refund_method_response = gateway.refund(purchase.amount * 100, purchase.payment_details[:authorization_code])
          if refund_method_response.success?
            success = true
          end
        else
          success = true
        end

        if success
          Notification.create(notification_type: "cancel_purchase", notified_id: purchase.seller_id, message: "The shipping proof for #{purchase.post.name} was not uploaded in time. The purchase was cancelled")
          Notification.create(notification_type: "cancel_purchase", notified_id: purchase.buyer_id, message: "The shipping proof for #{purchase.post.name} was not uploaded in time. The purchase was cancelled")

          seller = purchase.seller
          buyer = purchase.buyer
          seller_phone = seller&.phone
          buyer_phone = buyer&.phone
          message = "BikeFiesta - The shipping proof for #{purchase.post.name} was not uploaded in time. The purchase was cancelled."

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
        end
      end
    end
  end

  # Called hourly
  # It goes through the posts that were shipped more than 5 days ago and if the associated purchase is not on hold, then
  # we send the money to the seller
  def self.send_money_to_sellers
    ActiveMerchant::Billing::Base.mode = :test

    gateway = ActiveMerchant::Billing::PaypalGateway.new(
      login: ENV['PAYPAL_LOGIN'],
      password: ENV['PAYPAL_PASSWORD'],
      signature: ENV['PAYPAL_SIGNATURE']
    )

    Post.where(sold: true, shipped: true).where("shipped_date <= ?", 5.days.ago).joins(:purchase).where({purchase: {money_sent_to_seller: false}}).find_each do |post|
      purchase = post.purchase
      if !purchase.on_hold
        discount = 0
        seller = post.user
        if seller.discount.present?
          discount = seller.discount
        end
        if post.sale_percentage.nil?
          amount = ((90 + discount) / 100) * purchase.amount * 100
        else
          max_discount = post.sale_percentage > discount ? post.sale_percentage : discount
          amount = ((90 + max_discount) / 100) * purchase.amount * 100
        end

        # transfer = gateway.transfer(amount, purchase.seller.paypal_email, :subject => "Money for #{post.name}", :note => "Thank you for listing you bike on our site.")
        transfer = gateway.transfer(amount, 'sb-3orv825105929@personal.example.com', :subject => "Money for #{post.name}", :note => "Thank you for listing you bike on our site.")
        if transfer.success?
          Notification.create(notification_type: "money_sent", notified_id: purchase.seller_id, message: "The money for #{purchase.post.name} were sent to you")

          seller = purchase.seller
          seller_phone = seller&.phone

          if post.sale_percentage.nil?
            max_discount = discount
          end
          
          if seller.sms_opt_in
            message = "BikeFiesta - The money for #{purchase.post.name} were sent to you. Check your PayPal today. You also had a discount of #{max_discount}%."
            AsyncSendSmsToUser.perform_async(seller_phone, message)
          end

          user.discount = nil
          user.save(validate: false)

          purchase.money_sent_to_seller = true
          purchase.save
        end
      end
    end
  end
end