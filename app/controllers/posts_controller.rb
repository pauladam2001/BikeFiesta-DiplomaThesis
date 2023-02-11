class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  def index
    if params[:name].present?
      redirect_to all_posts_path(name: params[:name])
    else
      @most_viewed_posts = Post.order(views: :desc).limit(5)
      @sale_posts = Post.where.not(sale_price: [nil, ""]).limit(5)
      following_users = current_user.following
      @following_posts = Post.where(user_id: following_users).limit(5)
      @all_posts = Post.all.limit(5)
      @favorite_posts = current_user.favorite_posts
    end
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
    if params[:submitButton] == "Report Post"
      report(params[:id], current_user.id, params[:message], params[:title])
    else
      @post = Post.find(params[:id])
      @user = @post.user

      if current_user.id != @post.user_id
        @post.views += 1
        @post.save
      end
    end
  end

  def report(post_id, user_id, message, title)
    report = Report.find_or_create_by(post_id: post_id, user_id: user_id, message: message, title: title)
    
    redirect_to post_path(post_id)
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
    @most_viewed_posts = Post.order(views: :desc)
    @most_viewed_posts = @most_viewed_posts.paginate(page: params[:page], per_page: 16)
    @favorite_posts = current_user.favorite_posts
  end

  def on_sale_posts
    @on_sale_posts = Post.where.not(sale_price: [nil, ""])
    @on_sale_posts = @on_sale_posts.paginate(page: params[:page], per_page: 16)
    @favorite_posts = current_user.favorite_posts
  end

  def following_posts
    following_users = current_user.following
    @following_posts = Post.where(user_id: following_users)
    @following_posts = @following_posts.paginate(page: params[:page], per_page: 16)
    @favorite_posts = current_user.favorite_posts
  end

  def all_posts
    @all_posts = Post.all
    @favorite_posts = current_user.favorite_posts

    @users = User.where(role: "normal", archived: false).pluck(:full_name, :id)
    @colors = Color.order(:name).pluck(:name, :id)
    @locations = Location.order(:name).pluck(:name, :id)
    @brand_names = Brandname.order(:name).pluck(:name, :id)
    @categories = Category.order(:name).pluck(:name, :id)
    @materials = Material.order(:name).pluck(:name, :id)
    @component_groups = ComponentGroup.order(:name).pluck(:name, :id)

    @all_posts = @all_posts.where("name ilike?", "%#{params[:name]}%") if params[:name].present?
    @all_posts = @all_posts.where("description ilike?", "%#{params[:description]}%") if params[:description].present?
    @all_posts = @all_posts.where(condition: params[:condition]) if params[:condition].present? && params[:condition] != "all"
    @all_posts = @all_posts.where("year >= ?", params[:start_year]) if params[:start_year].present? && params[:start_year] != "all"
    @all_posts = @all_posts.where("year <= ?", params[:end_year]) if params[:end_year].present? && params[:end_year] != "all"
    @all_posts = @all_posts.where("price >= ? OR sale_price >= ?", params[:start_price], params[:start_price]) if params[:start_price].present? && params[:start_price] != "all"
    @all_posts = @all_posts.where("price <= ? OR sale_price <= ?", params[:end_price], params[:end_price]) if params[:end_price].present? && params[:end_price] != "all"
    @all_posts = @all_posts.where(user_id: params[:user]) if params[:user].present? && params[:user] != "all"
    @all_posts = @all_posts.where(color_id: params[:color]) if params[:color].present? && params[:color] != "all"
    @all_posts = @all_posts.where(location_id: params[:location]) if params[:location].present? && params[:location] != "all"
    @all_posts = @all_posts.where(brandname_id: params[:brand]) if params[:brand].present? && params[:brand] != "all"
    @all_posts = @all_posts.where(category_id: params[:category]) if params[:category].present? && params[:category] != "all"
    @all_posts = @all_posts.where(size: params[:size]) if params[:size].present? && params[:size] != "all"
    @all_posts = @all_posts.where(electric: params[:electric]) if params[:electric].present? && params[:electric] != "all"
    @all_posts = @all_posts.where(material_id: params[:material]) if params[:material].present? && params[:material] != "all"
    @all_posts = @all_posts.where(component_group_id: params[:component]) if params[:component].present? && params[:component] != "all"

    @all_posts = @all_posts.paginate(page: params[:page], per_page: 16)
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

  def ban
    post = Post.find(params[:id])
    post.is_active = -1
    post.save
    phone = post.user.phone
    AsyncSendSmsToUser.perform_async(phone)
    redirect_back(fallback_location: reports_path)
  end

  private
    def post_params
      params.require(:post).permit(:id, :name, :brandname_id, :location_id, :price, :description, :short_description, :color_id, :year, :post_id,
              :category_id, :material_id, :size, :electric, :component_group_id, :condition)
    end
end
