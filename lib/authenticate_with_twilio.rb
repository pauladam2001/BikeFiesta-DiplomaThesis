module AuthenticateWithTwilio
  extend ActiveSupport::Concern

  def authenticate_with_sms_code
    user = self.resource = find_user
    
    if session[:sms_code_user_id].present?
      authenticate_user_with_sms_code(user)
    elsif user&.valid_password?(user_params[:password])
      User.generate_code(user)
      crypt = ActiveSupport::MessageEncryptor.new(Base64.decode64(ENV['KEY']))
      send_auth_sms(user&.phone, crypt.decrypt_and_verify(user.code))
      prompt_for_sms_code(user, nil)
    end
  end

  private
    def valid_sms_code?(user)
      crypt = ActiveSupport::MessageEncryptor.new(Base64.decode64(ENV['KEY']))
      if user.code.present? && crypt.decrypt_and_verify(user.code) == params[:sms_code]
        return true
      else
        return false
      end
    end

    def prompt_for_sms_code(user, alert)
      @user = user
      session[:sms_code_user_id] = user.id
      render 'devise/sessions/two_factor', locals: { alert: alert }
    end

    def authenticate_user_with_sms_code(user)
      if valid_sms_code?(user)
        session.delete(:sms_code_user_id)
        remember_me(user) if user_params[:remember_me] == '1'

        user.code = nil
        user.code_expiration_date = nil
        user.save(validate: false)
        
        sign_in(user, event: :authentication)
      else
        params[:sms_code] = nil
        alert = "Error - The code you introduced is invalid. Please try again."
        prompt_for_sms_code(user, alert)
      end
    end

    def user_params
      params.require(:user).permit(:email, :password, :remember_me, :phone)
    end

    def find_user
      if session[:sms_code_user_id]
        User.find(session[:sms_code_user_id])
      elsif user_params[:email]
        User.find_by(email: user_params[:email])
      end
    end

    def send_auth_sms(phone, code)
      message = "BikeFiesta - Your code is " + code
      Marketing.send_sms(phone, message)
    end
end