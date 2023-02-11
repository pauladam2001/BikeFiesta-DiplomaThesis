class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def new
    @review = Review.new

    post = Post.find(params[:post_id])
    @reviewed = User.find(post.user_id)
  end

  def create
    reviewer_id = params[:reviewer_id].to_i
    reviewed_id = Post.find(params[:post_id]).user_id
    message = params[:message]
    if params[:grade].present?
      grade = params[:grade].to_i
    else
      grade = 1
    end
    
    @review = Review.new(reviewer_id: reviewer_id, reviewed_id: reviewed_id, message: message, grade: grade)
    if @review.save
      notification = Notification.where(post_id: params[:post_id], notified_id: reviewer_id).first
      notification.delete

      redirect_to posts_path
    end
  end
end
