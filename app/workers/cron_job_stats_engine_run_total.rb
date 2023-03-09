class CronJobStatsEngineRunTotal                      
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobStatsEngineRunTotal"
    StatsEngine.run_total
    puts "Finish Running CronJobStatsEngineRunTotal"
  end                     
end