class AsyncCheckImagesForPost
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform(post_id)
    puts "Running AsyncCheckImagesForPost"
    Marketing.check_images_for_post(post_id)
    puts "Finish Running AsyncCheckImagesForPost"
  end
end
