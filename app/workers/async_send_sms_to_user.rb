class AsyncSendSmsToUser
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform(phone, message)
    puts "Running AsyncSendSmsToUser"
    Marketing.send_sms(phone, message)
    puts "Finish Running AsyncSendSmsToUser"
  end
end
