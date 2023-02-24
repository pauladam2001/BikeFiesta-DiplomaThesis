class CronJobSendMoneyToSellers                      
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobSendMoneyToSellers"
    Marketing.send_money_to_sellers
    puts "Finish Running CronJobSendMoneyToSellers"
  end                     
end