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

  def show
    @user = User.find(params[:id])
    @current_user = current_user
    if @current_user.is_normal? && @user.is_normal?
      redirect_to posts_path, alert: "Error - You can not chat with other users."
      return
    end
    @rooms = Room.public_rooms
    if current_user.is_admin?
      @users = User.where.not(id: @current_user.id)
    else
      @users = User.where(role: "admin")
    end
    @room = Room.new
    @message = Message.new
    @room_name = get_name(@user, @current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)

    @single_room.last_read_at = Time.now
    @single_room.save

    @messages = @single_room.messages.order(created_at: :asc)

    @users = @users.paginate(page: params[:users_page], per_page: 12)
    @rooms = @rooms.paginate(page: params[:rooms_page], per_page: 28)

    render "rooms/index"
  end

  def follow_page
    @followers = current_user.followers
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
      redirect_to posts_path and return if current_user.is_normal? && (params[:action] != "follow_page" && params[:action] != "show")
    end

    def get_name(user1, user2)
      users = [user1, user2].sort
      "private_#{users[0].id}_#{users[1].id}"
    end
end
