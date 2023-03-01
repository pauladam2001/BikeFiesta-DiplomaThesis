class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  
  def create
    @current_user = current_user

    if msg_params[:content].present?
      crypt = ActiveSupport::MessageEncryptor.new(Base64.decode64(ENV['KEY']))
      encrypted_content = crypt.encrypt_and_sign(msg_params[:content])
      @message = @current_user.messages.create(content: encrypted_content, room_id: params[:room_id])
    end
  end

  private
    def msg_params
      params.require(:message).permit(:content)
    end
end
