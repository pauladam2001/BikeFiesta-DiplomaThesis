class RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  def index
    @current_user = current_user
    @rooms = Room.public_rooms
    @users = User.where.not(id: @current_user.id)
    @room = Room.new
  end

  def create
    @room = Room.create(name: params["room"]["name"], is_private: false)
  end

  def show
    @current_user = current_user
    @single_room = Room.find(params[:id])
    @rooms = Room.public_rooms
    @users = User.where.not(id: @current_user.id)
    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    render "index"
  end
end
