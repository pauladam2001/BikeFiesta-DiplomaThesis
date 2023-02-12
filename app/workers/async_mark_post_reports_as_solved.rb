class AsyncMarkPostReportsAsSolved
  include Sidekiq::Worker
  sidekiq_options queue: "default"
  def perform(post_id)
    puts "Running AsyncMarkPostReportsAsSolved"
    Marketing.mark_post_reports_as_solved(post_id)
    puts "Finish Running AsyncMarkPostReportsAsSolved"
  end
end
