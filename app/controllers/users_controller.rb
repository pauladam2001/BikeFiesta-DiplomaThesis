class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions
  
  def index
    if params[:submitButton] == "Refund User"
      refund_user(params[:user_id].to_i, params[:refund_amount].to_i)
    else
      @users = User.where.not(id: current_user.id).order(:email)

      @users = @users.where("email ilike?", "%#{params[:email]}%") if params[:email].present?
      @users = @users.where("full_name ilike?", "%#{params[:name]}%") if params[:name].present?
      @users = @users.where(role: params[:role]) if params[:role].present? && params[:role] != "all"

      if params[:archived].present?
        @users = @users.where(archived: params[:archived])
      else
        @users = @users.where(archived: false)
      end

      @total_stats = {
        total_users: User.where(role: "normal").count,
        archived_users: User.where(role: "normal", archived: true).count
      }
      @total_stats[:unarchived_users] = @total_stats[:total_users] - @total_stats[:archived_users]

      @users = @users.paginate(page: params[:page], per_page: 12)
    end
  end

  def refund_user(user_id, amount)
    ActiveMerchant::Billing::Base.mode = :test

    gateway = ActiveMerchant::Billing::PaypalGateway.new(
      login: ENV['PAYPAL_LOGIN'],
      password: ENV['PAYPAL_PASSWORD'],
      signature: ENV['PAYPAL_SIGNATURE']
    )

    user = User.find(user_id)

    if Cost.where(amount: amount, description: "Refund for #{user.email}", day: Date.today).count == 0
      # transfer = gateway.transfer(amount, user.paypal_email, :subject => "Refund", :note => "Sorry for the inconvenience.")
      transfer = gateway.transfer(amount * 100, 'sb-3orv825105929@personal.example.com', :subject => "Refund", :note => "Sorry for the inconvenience.")
      if transfer.success?
        Notification.create(notification_type: "money_sent", notified_id: user.id, message: "€#{amount} were refunded to you")

        message = "BikeFiesta - €#{amount} were refunded to you."

        AsyncSendSmsToUser.perform_async(user&.phone, message)

        Cost.create(amount: amount, description: "Refund for #{user.email}", day: Date.today)

        redirect_back(fallback_location: users_path, alert: "User refunded and cost created successfully.")
      end
    else
      redirect_back(fallback_location: users_path, alert: "Error - The user was already refunded.")
    end
  end

  def show
    require 'will_paginate/array'
    
    @user = User.find(params[:id])
    @current_user = current_user
    if @current_user.is_normal? && @user.is_normal?
      redirect_to posts_path, alert: "Error - You can not chat with other users."
      return
    end
    @rooms = Room.public_rooms
    @no_message_rooms = @rooms.joins("LEFT OUTER JOIN messages ON messages.room_id = rooms.id").where('messages.id IS NULL').uniq
    @rooms = @rooms.ordered + @no_message_rooms
    if current_user.is_admin?
      @users = User.where.not(id: @current_user.id)
    else
      @users = User.where(role: "admin")
    end
    @users = @users.order(:full_name)     #TODO check this
    @room = Room.new
    @message = Message.new
    @room_name = get_name(@user, @current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)

    participant = Participant.find_or_create_by(user_id: current_user.id, room_id: @single_room.id)
    participant.last_read_at = Time.now
    participant.save

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
    redirect_back(fallback_location: users_path, alert: "User archived successfully.")
  end

  def unarchive_user
    user = User.find(params[:id])
    user.archived = false
    user.save(validate: false)
    redirect_back(fallback_location: users_path, alert: "User unarchived successfully.")
  end

  def make_user_admin
    user = User.find(params[:id])
    user.role = "admin"
    user.save(validate: false)
    redirect_back(fallback_location: users_path, alert: "#{user.full_name} updated successfully.")
  end

  def remove_user_admin
    user = User.find(params[:id])
    user.role = "normal"
    user.save(validate: false)
    redirect_back(fallback_location: users_path, alert: "#{user.full_name} updated successfully.")
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
