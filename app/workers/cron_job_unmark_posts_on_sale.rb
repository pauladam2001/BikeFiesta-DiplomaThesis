class CronJobUnmarkPostsOnSale                        
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobUnmarkPostsOnSale"
    Marketing.unmark_posts_on_sale
    puts "Finish Running CronJobUnmarkPostsOnSale"
  end                     
end