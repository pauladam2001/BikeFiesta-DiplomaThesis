class CronJobResetUserCodes                     
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobResetUserCodes"
    Marketing.reset_user_codes
    puts "Finish Running CronJobResetUserCodes"
  end                     
end