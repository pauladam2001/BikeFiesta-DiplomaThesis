class CronJobMarkPostsOnSale                        
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobMarkPostsOnSale"
    Marketing.mark_posts_on_sale
    puts "Finish Running CronJobMarkPostsOnSale"
  end                     
end