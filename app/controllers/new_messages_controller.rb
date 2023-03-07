class NewMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions

  def index
    require 'will_paginate/array'

    @unread_rooms = []
    all_rooms = Room.all

    all_rooms.each do |room|
      participant = room.participants.where(user_id: current_user.id).first
      last_message = room.messages.order(created_at: :asc).last
      if (last_message.present? && last_message.user_id != current_user.id) && (participant&.last_read_at.nil? || last_message.created_at > participant&.last_read_at)
        @unread_rooms << room
      end
    end

    @unread_rooms = @unread_rooms.paginate(page: params[:page], per_page: 12)
  end

  private
    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
