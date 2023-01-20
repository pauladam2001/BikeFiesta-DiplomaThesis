class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @locations = Location.order(:name).pluck(:name, :id)
    @brand_names = Brandname.order(:name).pluck(:name, :id)
    @colors = Color.order(:name).pluck(:name, :id)
  end

  def edit
    @post = Post.find(params[:id])
    @locations = Location.order(:name).pluck(:name, :id)
    @brand_names = Brandname.order(:name).pluck(:name, :id)
    @colors = Color.order(:name).pluck(:name, :id)
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
      x = (Random.rand(3..10) * 100).seconds.from_now
      # AsyncCheckImagesForPost.perform_in(x, @post.id)   # by the time this is called the user already uploaded the images
      redirect_to edit_post_path(@post, upload: true)
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
    binding.pry
    asset = Asset.new
    asset.post_id = params[:post_id]
    asset.user_id = current_user.id
    asset.image = params[:file]
    asset.save
  end

  def my_posts
    @posts = Post.where(user_id: current_user.id)
  end

  private
    def post_params
      params.require(:post).permit(:id, :name, :brandname_id, :location_id, :price, :description, :short_description, :color_id, :year, :post_id)
    end
end
