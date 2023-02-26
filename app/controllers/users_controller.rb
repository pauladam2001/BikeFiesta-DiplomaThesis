class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions
  
  def index
    @users = User.order(:email)

    @users = @users.where("email ilike?", "%#{params[:email]}%") if params[:email].present?
    @users = @users.where("full_name ilike?", "%#{params[:name]}%") if params[:name].present?
    @users = @users.where(role: params[:role]) if params[:role].present? && params[:role] != "all"

    @users = @users.paginate(page: params[:page], per_page: 12)
  end

  def follow_page
    @followers = current_user.followers     # TODO observer/socket or how we will implement the buy button/chat app
    @following = current_user.following

    if params[:name].present?
      @followers = @followers.where("full_name ilike?", "%#{params[:name]}%")
      @following = @following.where("full_name ilike?", "%#{params[:name]}%")
    end

    @followers = @followers.paginate(page: params[:page], per_page: 30)
    @following = @following.paginate(page: params[:page], per_page: 30)
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
      redirect_to posts_path and return if current_user.is_normal? && params[:action] != "follow_page"
    end
end
