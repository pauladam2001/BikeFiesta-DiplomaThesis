class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  def index
    @current = 1
    @posts = Post.all
  end

  def new
    @current = 3
    @post = Post.new
    @locations = Location.order(:name).pluck(:name, :id)
    @brand_names = Brandname.order(:name).pluck(:name, :id)
    @colors = Color.order(:name).pluck(:name, :id)
  end

  def edit
    @post = Post.find(params[:id])
    render :new
  end

  def update
    @post = Post.find(params[:id])
    @post.attributes = post_params
    if @post.save!
      redirect_to posts_path
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      redirect_back(fallback_location: posts_path, alert: "Error - #{@post.errors.full_messages.first}.")
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  # Receives a hash of images
  def upload
    
  end

  private
    def post_params
      params.require(:post).permit(:id, :name, :brandname_id, :location_id, :price, :description, :short_description, :color_id, :year)
    end
end
