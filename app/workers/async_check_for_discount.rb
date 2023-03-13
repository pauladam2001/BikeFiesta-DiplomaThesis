class AsyncCheckForDiscount
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform(user_id, type)
    puts "Running AsyncCheckImagesForPost"
    
    user = User.find(user_id)

    if type == "seller"
      if user.posts.where(sold: true, shipped: true).count % 5 == 0
        user.discount = 5

        Notification.create(notification_type: "discount", notified_id: user_id, message: "You have a 5% discount on your next sell/order")

        seller_message = "BikeFiesta - You have a 5% discount on your next sell/order."

        AsyncSendSmsToUser.perform_async(user&.phone, seller_message)
      else
        user.discount = nil
      end
      user.save(validate: false)
    elsif type == "buyer"
      if Post.where(sold: true, shipped: true, buyer_id: user_id).count % 5 == 0
        user.discount = 5

        Notification.create(notification_type: "discount", notified_id: user_id, message: "You have a 5% discount on your next order/sell")

        buyer_message = "BikeFiesta - You have a 5% discount on your next sell/order."

        AsyncSendSmsToUser.perform_async(user&.phone, buyer_message)
      else
        user.discount = nil
      end
      user.save(validate: false)
    end

    puts "Finish Running AsyncCheckImagesForPost"
  end
end
