class RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions

  def index
    require 'will_paginate/array'
    
    @current_user = current_user

    @unread_rooms = Room.public_rooms.joins(:message_statuses).where('message_statuses.user_id = ?', current_user.id).select('rooms.id as id, message_statuses.user_id as msg_user_id')
    @unread_rooms_ids = []
    @unread_rooms.each do |room|
      @unread_rooms_ids << room.id
    end
    @rooms = Room.public_rooms.where(id: @unread_rooms_ids)
    @rooms += Room.public_rooms.where.not(id: @unread_rooms_ids)

    @unread_users = User.joins(:message_statuses).where('message_statuses.user_id = ?', current_user.id).select('users.id as id, message_statuses.room_id as msg_room_id')
    @unread_users_ids = []
    @unread_users.each do |user|
      private_room = Room.where(id: user.msg_room_id, is_private: true).first
      if private_room.present?
        other_participant = private_room.participants.where.not(user_id: current_user.id).first
        @unread_users_ids << other_participant.user_id
      end
    end
    if current_user.is_admin?
      @partial_users = User.where.not(id: @current_user.id)
    else
      @partial_users = User.where(role: "admin")
    end
    @users = @partial_users.where(id: @unread_users_ids)
    @users += @partial_users.where.not(id: @unread_users_ids)

    @room = Room.new

    @users = @users.paginate(page: params[:users_page], per_page: 12)
    @rooms = @rooms.paginate(page: params[:rooms_page], per_page: 28)
  end

  def create
    @room = Room.create(name: params["room"]["name"], is_private: false)
  end

  def show
    @current_user = current_user
    @single_room = Room.find(params[:id])

    @unread_rooms = Room.public_rooms.joins(:message_statuses).where('message_statuses.user_id = ?', current_user.id).select('rooms.id as id, message_statuses.user_id as msg_user_id')
    @unread_rooms_ids = []
    @unread_rooms.each do |room|
      @unread_rooms_ids << room.id
    end
    @rooms = Room.public_rooms.where(id: @unread_rooms_ids)
    @rooms += Room.public_rooms.where.not(id: @unread_rooms_ids)

    @unread_users = User.joins(:message_statuses).where('message_statuses.user_id = ?', current_user.id).select('users.id as id, message_statuses.room_id as msg_room_id')
    @unread_users_ids = []
    @unread_users.each do |user|
      private_room = Room.where(id: user.msg_room_id, is_private: true).first
      if private_room.present?
        other_participant = private_room.participants.where.not(user_id: current_user.id).first
        @unread_users_ids << other_participant.user_id
      end
    end
    if current_user.is_admin?
      @partial_users = User.where.not(id: @current_user.id)
    else
      @partial_users = User.where(role: "admin")
    end
    @users = @partial_users.where(id: @unread_users_ids)
    @users += @partial_users.where.not(id: @unread_users_ids)

    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    MessageStatus.where(room_id: @single_room.id, user_id: current_user.id).delete_all

    @users = @users.paginate(page: params[:users_page], per_page: 12)
    @rooms = @rooms.paginate(page: params[:rooms_page], per_page: 28)

    render "index"
  end

  private
    def check_permissions
      redirect_to posts_path and return if current_user.is_normal? && params[:action] == "show"
    end
end
