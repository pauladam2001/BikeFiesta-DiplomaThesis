class AsyncSendSmsToFollowers
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform(user_id)
    puts "Running AsyncSendSmsToFollowers"
    user = User.find(user_id)
    message = "BikeFiesta - #{user.full_name} just posted a new bike for sale, go check it out!"

    user.followers.each do |follower|
      phone = follower.phone
      Marketing.send_sms(phone, message)
    end
    puts "Finish Running AsyncSendSmsToFollowers"
  end
end
