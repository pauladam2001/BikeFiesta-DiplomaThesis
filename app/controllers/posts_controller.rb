class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  def index
    @most_viewed_posts = Post.all.limit(5)
    @sale_posts = Post.all.limit(5)
    @following_posts = Post.all.limit(5)
    @all_posts = Post.all.limit(5)
    @favorite_posts = current_user.favorite_posts
  end

  def new
    @post = Post.new
    @locations = Location.order(:name).pluck(:name, :id)
    @brand_names = Brandname.order(:name).pluck(:name, :id)
    @colors = Color.order(:name).pluck(:name, :id)
    @categories = Category.order(:name).pluck(:name, :id)
    @materials = Material.order(:name).pluck(:name, :id)
    @component_groups = ComponentGroup.order(:name).pluck(:name, :id)
  end

  def edit
    @post = Post.find(params[:id])
    @locations = Location.order(:name).pluck(:name, :id)
    @brand_names = Brandname.order(:name).pluck(:name, :id)
    @colors = Color.order(:name).pluck(:name, :id)
    @categories = Category.order(:name).pluck(:name, :id)
    @materials = Material.order(:name).pluck(:name, :id)
    @component_groups = ComponentGroup.order(:name).pluck(:name, :id)
    render :new
  end

  def update
    @post = Post.find(params[:id])
    @post.attributes = post_params
    if @post.save
      redirect_to my_posts_path
    else
      redirect_back(fallback_location: my_posts_path, alert: "Error - #{@post.errors.full_messages.first}.")
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

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  # Receives a hash of images
  def upload
    asset = Asset.new
    asset.post_id = params[:post_id]
    asset.user_id = current_user.id
    asset.image = params[:file]
    asset.save
  end

  def my_posts
    @my_posts = Post.where(user_id: current_user.id)
    @my_posts = @my_posts.paginate(page: params[:page], per_page: 16)
  end

  def most_viewed_posts
    @most_viewed_posts = Post.all
    @most_viewed_posts = @most_viewed_posts.paginate(page: params[:page], per_page: 16)
    @favorite_posts = current_user.favorite_posts
  end

  def on_sale_posts
    @on_sale_posts = Post.all
    @on_sale_posts = @on_sale_posts.paginate(page: params[:page], per_page: 16)
    @favorite_posts = current_user.favorite_posts
  end

  def following_posts
    @following_posts = Post.all
    @following_posts = @following_posts.paginate(page: params[:page], per_page: 16)
    @favorite_posts = current_user.favorite_posts
  end

  def all_posts
    @all_posts = Post.all
    @all_posts = @all_posts.paginate(page: params[:page], per_page: 16)
    @favorite_posts = current_user.favorite_posts
  end

  def favorites
    @favorites = current_user.favorite_posts
    @favorites = @favorites.paginate(page: params[:page], per_page: 16)
  end

  def add_to_favorites
    post_id = params[:id]
    user_id= current_user.id
    new_favorite = Favorite.find_or_create_by(post_id: post_id, user_id: user_id)
    redirect_back(fallback_location: posts_path)
  end

  def remove_from_favorites
    post_id = params[:id]
    user_id= current_user.id
    favorite = Favorite.where(post_id: post_id, user_id: user_id).first
    favorite.delete
    redirect_back(fallback_location: posts_path)
  end

  private
    def post_params
      params.require(:post).permit(:id, :name, :brandname_id, :location_id, :price, :description, :short_description, :color_id, :year, :post_id,
              :category_id, :material_id, :size, :electric, :component_group_id, :condition)
    end
end
