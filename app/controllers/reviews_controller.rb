class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    if current_user.is_normal?
      redirect_to posts_path
      return
    end

    @reviews = Review.order(created_at: :desc)

    @users = User.order(:full_name).pluck(:full_name, :id)

    @reviews = @reviews.where("message ilike?", "%#{params[:message]}%") if params[:message].present?
    @reviews = @reviews.where(grade: params[:grade].to_i) if params[:grade].present?

    start_date, end_date = nil, nil
    start_date = params[:start_date].to_date.beginning_of_day if params[:start_date].present? && params[:start_date] != "all"
    end_date = params[:end_date].to_date.end_of_day if params[:end_date].present? && params[:end_date] != "all"

    @reviews = @reviews.where("reviews.created_at >= ?", start_date) if params[:start_date].present? && params[:start_date] != "all"
    @reviews = @reviews.where("reviews.created_at <= ?", end_date) if params[:end_date].present? && params[:end_date] != "all"

    @reviews = @reviews.where(reviewer_id: params[:reviewer]) if params[:reviewer].present? && params[:reviewer] != "all"
    @reviews = @reviews.where(reviewed_id: params[:reviewed]) if params[:reviewed].present? && params[:reviewed] != "all"

    @reviews = @reviews.paginate(page: params[:page], per_page: 15)
  end

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

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end
end
