class RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions

  def index
    require 'will_paginate/array'
    
    @current_user = current_user
    @rooms = Room.public_rooms
    @no_message_rooms = @rooms.joins("LEFT OUTER JOIN messages ON messages.room_id = rooms.id").where('messages.id IS NULL').uniq
    @rooms = @rooms.ordered + @no_message_rooms   #TODO check this
    if current_user.is_admin?
      @users = User.where.not(id: @current_user.id)
    else
      @users = User.where(role: "admin")
    end
    @users = @users.order(:full_name)     #TODO check this
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

    participant = Participant.find_or_create_by(user_id: current_user.id, room_id: @single_room.id)
    participant.last_read_at = Time.now
    participant.save

    @rooms = Room.public_rooms
    @no_message_rooms = @rooms.joins("LEFT OUTER JOIN messages ON messages.room_id = rooms.id").where('messages.id IS NULL').uniq
    @rooms = @rooms.ordered + @no_message_rooms
    @users = User.where.not(id: @current_user.id)
    @users = @users.order(:full_name)
    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    @users = @users.paginate(page: params[:users_page], per_page: 12)
    @rooms = @rooms.paginate(page: params[:rooms_page], per_page: 28)

    render "index"
  end

  private
    def check_permissions
      redirect_to posts_path and return if current_user.is_normal? && params[:action] == "show"
    end
end
