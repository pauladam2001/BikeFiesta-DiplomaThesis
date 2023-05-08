class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  def index
    if params[:submitButton] == "Send Suggestion"
      send_suggestion(current_user.id, params[:suggestion])
    end

    if params[:name].present?
      redirect_to all_posts_path(name: params[:name])
    else
      @most_viewed_posts = Post.where(is_active: 1).where.not(user_id: current_user.id).order(views: :desc).limit(5)
      @sale_posts = Post.where(is_active: 1).where.not(user_id: current_user.id).where.not(sale_price: [nil, ""]).limit(5)
      following_users = current_user.following
      @following_posts = Post.where(is_active: 1).where(user_id: following_users).limit(5)
      @all_posts = Post.where(is_active: 1).where.not(user_id: current_user.id).limit(5)
      @favorite_posts = current_user.favorite_posts
    end
  end

  def new
    if current_user.paypal_email.nil?
      redirect_back(fallback_location: posts_path, alert: "Error - Please introduce your PayPal Email (see your Profile Page) before listing a bicycle for sale.")
      return
    end
    if current_user.phone.nil?
      redirect_back(fallback_location: posts_path, alert: "Error - Please introduce your Phone Number (see your Profile Page) before listing a bicycle for sale.")
      return
    end
    
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
      redirect_to my_posts_path, alert: "Post #{@post.name} updated successfully."
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
      @favorite_posts = current_user.favorite_posts
      
      @post = Post.find(params[:id])
      @user = @post.user

      @reviews = Review.where(reviewed_id: @user.id).order(created_at: :desc).limit(50)

      if current_user.id != @post.user_id
        @post.views += 1
        @post.save
      end
    end
  end

  def report(post_id, user_id, message, title)
    report = Report.find_or_create_by(post_id: post_id, user_id: user_id, message: message, title: title)
    
    redirect_to post_path(post_id), alert: "Thank you for your report."
  end

  def send_suggestion(user_id, message)
    Suggestion.create(user_id: user_id, message: message)

    redirect_to posts_path, alert: "Suggestion sent successfully."
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_back(fallback_location: posts_path, alert: "Post deleted successfully.")
  end

  def upload
    asset = Asset.new
    asset.post_id = params[:post_id]
    asset.user_id = current_user.id
    asset.image = params[:file]
    asset.save
  end

  def upload_proof
    if params[:method] == "post"
      post = Post.find(params[:post_id])
      purchase = post.purchase
      purchase.proof = params[:file]
      purchase.status = "AUTHORIZED_PROOF"
      purchase.save
      redirect_back(fallback_location: bikes_to_ship_path, alert: "Proof uploaded successfully.")
    end
  end

  def my_posts
    @my_posts = Post.where(user_id: current_user.id).order(is_active: :desc)
    
    @my_posts = @my_posts.paginate(page: params[:page], per_page: 16)
  end

  def bikes_to_ship
    @bikes_to_ship = Post.where(user_id: current_user.id, sold: true, shipped: false)   # or is_active: -2

    @bikes_to_ship = @bikes_to_ship.paginate(page: params[:page], per_page: 16)
  end

  def bought_bikes
    @bought_bikes = Post.where(buyer_id: current_user.id, sold: true, shipped: true)    # or is_active: -3

    @bought_bikes = @bought_bikes.paginate(page: params[:page], per_page: 16)
  end

  def most_viewed_posts
    @most_viewed_posts = Post.where(is_active: 1).order(views: :desc)
    @favorite_posts = current_user.favorite_posts

    @users = User.where(role: "normal", archived: false).pluck(:full_name, :id)
    @colors = Color.order(:name).pluck(:name, :id)
    @locations = Location.order(:name).pluck(:name, :id)
    @brand_names = Brandname.order(:name).pluck(:name, :id)
    @categories = Category.order(:name).pluck(:name, :id)
    @materials = Material.order(:name).pluck(:name, :id)
    @component_groups = ComponentGroup.order(:name).pluck(:name, :id)

    @most_viewed_posts = search_posts(@most_viewed_posts)

    @most_viewed_posts = @most_viewed_posts.paginate(page: params[:page], per_page: 16)
  end

  def on_sale_posts
    @on_sale_posts = Post.where(is_active: 1).where.not(sale_price: [nil, ""])
    @favorite_posts = current_user.favorite_posts

    @users = User.where(role: "normal", archived: false).pluck(:full_name, :id)
    @colors = Color.order(:name).pluck(:name, :id)
    @locations = Location.order(:name).pluck(:name, :id)
    @brand_names = Brandname.order(:name).pluck(:name, :id)
    @categories = Category.order(:name).pluck(:name, :id)
    @materials = Material.order(:name).pluck(:name, :id)
    @component_groups = ComponentGroup.order(:name).pluck(:name, :id)

    @on_sale_posts = search_posts(@on_sale_posts)

    @on_sale_posts = @on_sale_posts.paginate(page: params[:page], per_page: 16)
  end

  def following_posts
    following_users = current_user.following
    @following_posts = Post.where(is_active: 1).where(user_id: following_users)
    @favorite_posts = current_user.favorite_posts

    @users = User.where(role: "normal", archived: false).pluck(:full_name, :id)
    @colors = Color.order(:name).pluck(:name, :id)
    @locations = Location.order(:name).pluck(:name, :id)
    @brand_names = Brandname.order(:name).pluck(:name, :id)
    @categories = Category.order(:name).pluck(:name, :id)
    @materials = Material.order(:name).pluck(:name, :id)
    @component_groups = ComponentGroup.order(:name).pluck(:name, :id)

    @following_posts = search_posts(@following_posts)

    @following_posts = @following_posts.paginate(page: params[:page], per_page: 16)
  end

  def all_posts
    @all_posts = Post.where(is_active: 1)
    @favorite_posts = current_user.favorite_posts

    @users = User.where(role: "normal", archived: false).pluck(:full_name, :id)
    @colors = Color.order(:name).pluck(:name, :id)
    @locations = Location.order(:name).pluck(:name, :id)
    @brand_names = Brandname.order(:name).pluck(:name, :id)
    @categories = Category.order(:name).pluck(:name, :id)
    @materials = Material.order(:name).pluck(:name, :id)
    @component_groups = ComponentGroup.order(:name).pluck(:name, :id)

    @all_posts = search_posts(@all_posts)

    @all_posts = @all_posts.paginate(page: params[:page], per_page: 16)
  end

  def favorites
    @favorites = current_user.favorite_posts.where(is_active: 1)    # also we delete the Favorite entries for a post that is sold

    @users = User.where(role: "normal", archived: false).pluck(:full_name, :id)
    @colors = Color.order(:name).pluck(:name, :id)
    @locations = Location.order(:name).pluck(:name, :id)
    @brand_names = Brandname.order(:name).pluck(:name, :id)
    @categories = Category.order(:name).pluck(:name, :id)
    @materials = Material.order(:name).pluck(:name, :id)
    @component_groups = ComponentGroup.order(:name).pluck(:name, :id)

    @favorites = @favorites.paginate(page: params[:page], per_page: 16)
  end

  def user_posts
    user = User.find(params[:user_id])
    @user_posts = user.posts.where(is_active: 1)

    @user_posts = @user_posts.paginate(page: params[:page], per_page: 16)
  end

  def add_to_favorites
    post_id = params[:id]
    user_id= current_user.id

    if Post.find(post_id).user_id == user_id
      redirect_back(fallback_location: posts_path, alert: "Error - You can't add your own bicycle to favorites.")
      return
    end

    new_favorite = Favorite.find_or_create_by(post_id: post_id, user_id: user_id)
    redirect_back(fallback_location: posts_path, alert: "Post successfully added to favorites.")
  end

  def remove_from_favorites
    post_id = params[:id]
    user_id= current_user.id
    favorite = Favorite.where(post_id: post_id, user_id: user_id).first
    favorite.delete
    redirect_back(fallback_location: posts_path, alert: "Post successfully removed to favorites.")
  end

  def ban
    post = Post.find(params[:id])
    post.is_active = -1
    post.save

    user = post.user
    if user.sms_opt_in
      phone = user.phone
      message = "BikeFiesta - Your post #{post.name} was banned."
      AsyncSendSmsToUser.perform_async(phone, message)
    end

    AsyncMarkPostReportsAsSolved.perform_async(post.id)

    redirect_back(fallback_location: reports_path, alert: "Post banned successfully.")
  end

  protected
    def search_posts(posts)
      filtered_posts = posts

      filtered_posts = filtered_posts.where("name ilike?", "%#{params[:name]}%") if params[:name].present?
      filtered_posts = filtered_posts.where("description ilike?", "%#{params[:description]}%") if params[:description].present?
      filtered_posts = filtered_posts.where(condition: params[:condition]) if params[:condition].present? && params[:condition] != "all"
      filtered_posts = filtered_posts.where("year >= ?", params[:start_year]) if params[:start_year].present? && params[:start_year] != "all"
      filtered_posts = filtered_posts.where("year <= ?", params[:end_year]) if params[:end_year].present? && params[:end_year] != "all"
      filtered_posts = filtered_posts.where("price >= ? OR sale_price >= ?", params[:start_price], params[:start_price]) if params[:start_price].present? && params[:start_price] != "all"
      filtered_posts = filtered_posts.where("price <= ? OR sale_price <= ?", params[:end_price], params[:end_price]) if params[:end_price].present? && params[:end_price] != "all"
      filtered_posts = filtered_posts.where(user_id: params[:user]) if params[:user].present? && params[:user] != "all"
      filtered_posts = filtered_posts.where(color_id: params[:color]) if params[:color].present? && params[:color] != "all"
      filtered_posts = filtered_posts.where(location_id: params[:location]) if params[:location].present? && params[:location] != "all"
      filtered_posts = filtered_posts.where(brandname_id: params[:brand]) if params[:brand].present? && params[:brand] != "all"
      filtered_posts = filtered_posts.where(category_id: params[:category]) if params[:category].present? && params[:category] != "all"
      filtered_posts = filtered_posts.where(size: params[:size]) if params[:size].present? && params[:size] != "all"
      filtered_posts = filtered_posts.where(electric: params[:electric]) if params[:electric].present? && params[:electric] != "all"
      filtered_posts = filtered_posts.where(material_id: params[:material]) if params[:material].present? && params[:material] != "all"
      filtered_posts = filtered_posts.where(component_group_id: params[:component]) if params[:component].present? && params[:component] != "all"

      return filtered_posts
    end

  private
    def post_params
      params.require(:post).permit(:id, :name, :brandname_id, :location_id, :price, :description, :short_description, :color_id, :year, :post_id,
              :category_id, :material_id, :size, :electric, :component_group_id, :condition)
    end
end
