class CronJobStatsEngineRunUsersTotal                        
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobStatsEngineRunUsersTotal"
    StatsEngine.run_users_total
    puts "Finish Running CronJobStatsEngineRunUsersTotal"
  end                     
end