class CronJobCheckPostsToBeShipped                      
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobCheckPostsToBeShipped"
    Marketing.check_posts_to_be_shipped
    puts "Finish Running CronJobCheckPostsToBeShipped"
  end                     
end