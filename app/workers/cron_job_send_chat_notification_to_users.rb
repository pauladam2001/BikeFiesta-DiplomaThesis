class CronJobSendChatNotificationToUsers                      
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobSendChatNotificationToUsers"
    Marketing.send_chat_notification_to_users
    puts "Finish Running CronJobSendChatNotificationToUsers"
  end                     
end