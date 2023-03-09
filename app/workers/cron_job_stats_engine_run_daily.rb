class CronJobStatsEngineRunDaily                        
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobStatsEngineRunDaily"
    StatsEngine.run_daily
    puts "Finish Running CronJobStatsEngineRunDaily"
  end                     
end