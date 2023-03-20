class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  def create
    @current_user = current_user

    if msg_params[:content].present?
      room = Room.find(params[:room_id])

      crypt = ActiveSupport::MessageEncryptor.new(Base64.decode64(ENV['KEY']))
      encrypted_content = crypt.encrypt_and_sign(msg_params[:content])
      @message = @current_user.messages.create(content: encrypted_content, room_id: room.id)

      if room.is_private?
        room.participants.each do |participant|
          if participant.user_id != current_user.id
            MessageStatus.create(message_id: @message.id, user_id: participant.user_id, room_id: room.id)
          end
        end
      else
        User.where(role: "admin").where.not(id: current_user.id).each do |user|
          MessageStatus.create(message_id: @message.id, user_id: user.id, room_id: room.id)
        end
      end
    end
  end

  private
    def msg_params
      params.require(:message).permit(:content)
    end
end
