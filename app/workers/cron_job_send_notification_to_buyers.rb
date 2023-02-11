class CronJobSendNotificationToBuyers                      
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobSendNotificationToBuyers"
    Marketing.send_notification_to_buyers
    puts "Finish Running CronJobSendNotificationToBuyers"
  end                     
end