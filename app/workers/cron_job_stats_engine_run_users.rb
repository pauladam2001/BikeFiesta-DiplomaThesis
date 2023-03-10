class CronJobStatsEngineRunUsers                        
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobStatsEngineRunUsers"
    StatsEngine.run_users
    puts "Finish Running CronJobStatsEngineRunUsers"
  end                     
end