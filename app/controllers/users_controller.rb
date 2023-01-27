class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions
  
  def index
    @users = User.order(:email)
    @users = @users.paginate(page: params[:page], per_page: 12)
  end

  def show

  end

  def followers_following_page

  end

  def archive_user
    user = User.find(params[:id])
    user.archived = true
    user.save(validate: false)
    redirect_back(fallback_location: users_path)
  end

  def unarchive_user
    user = User.find(params[:id])
    user.archived = false
    user.save(validate: false)
    redirect_back(fallback_location: users_path)
  end

  def make_user_admin
    user = User.find(params[:id])
    user.role = "admin"
    user.save(validate: false)
    redirect_back(fallback_location: users_path)
  end

  def remove_user_admin
    user = User.find(params[:id])
    user.role = "normal"
    user.save(validate: false)
    redirect_back(fallback_location: users_path)
  end

  private
    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
