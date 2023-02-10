class AsyncSendSmsToUser
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform(phone)
    puts "Running AsyncSendSmsToUser"
    message = "BikeFiesta - One of the posts that you reported was banned. Thank you!"
    Marketing.send_sms(phone, message)
    puts "Finish Running AsyncSendSmsToUser"
  end
end
