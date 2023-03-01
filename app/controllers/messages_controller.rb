class MessagesController < ApplicationController
  def create
    @current_user = current_user

    crypt = ActiveSupport::MessageEncryptor.new(Base64.decode64(ENV['KEY']))
    encrypted_content = crypt.encrypt_and_sign(msg_params[:content])
    @message = @current_user.messages.create(content: encrypted_content, room_id: params[:room_id])
  end

  private
    def msg_params
      params.require(:message).permit(:content)
    end
end
