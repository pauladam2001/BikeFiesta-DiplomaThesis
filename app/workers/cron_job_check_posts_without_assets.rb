class CronJobCheckPostsWithoutAssets                        
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running AsyncCheckPostsWithoutAssets"
    Marketing.check_posts_without_assets
    puts "Finish Running AsyncCheckPostsWithoutAssets"
  end                     
end