class CronJobCalculateUsersRating                        
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform()                     
    puts "Running CronJobCalculateUsersRating"
    Marketing.calculate_users_rating
    puts "Finish Running CronJobCalculateUsersRating"
  end                     
end