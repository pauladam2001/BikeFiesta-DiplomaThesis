module AuthenticateWithTwilio
  extend ActiveSupport::Concern

  def authenticate_with_otp_two_factor
    user = self.resource = find_user
    if session[:otp_user_id].present?
      authenticate_user_with_otp_two_factor(user)
    elsif user&.valid_password?(user_params[:password])
      User.generate_code(user)
      # code = send_sms(user.phone, user.code)
      prompt_for_otp_two_factor(user)
    end
  end

  private

  def valid_otp_attempt?(user)
    # user.validate_and_consume_otp!(user_params[:otp_attempt])
    binding.pry
    if user.code == user_params[:code]
      return true
    else
      return false
    end
  end

  def prompt_for_otp_two_factor(user)
      @user = user
      session[:otp_user_id] = user.id
      render 'devise/sessions/two_factor'
  end

  def authenticate_user_with_otp_two_factor(user)
      binding.pry
      if valid_otp_attempt?(user)
      # Remove any lingering user data from login
      session.delete(:otp_user_id)

      remember_me(user) if user_params[:remember_me] == '1'
      user.save!
      sign_in(user, event: :authentication)
      else
      flash.now[:alert] = 'Invalid two-factor code.'
      prompt_for_otp_two_factor(user)
      end
  end

  def user_params
      params.require(:user).permit(:email, :password, :remember_me, :code, :phone, :sms_attempt)
  end

  def find_user
      if session[:otp_user_id]
      User.find(session[:otp_user_id])
      elsif user_params[:email]
      User.find_by(email: user_params[:email])
      end
  end

  def send_sms(number, code)
    require 'twilio-ruby'

    account_sid = ENV['TWILLIO_ACCOUNT_SID']
    auth_token = ENV['TWILLIO_AUTH_TOKEN']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = '+15162615353'
    to = '+40773346603'
    # code = Random.rand.to_s[2..7]
    binding.pry
    client.messages.create(
      from: from,
      to: to,
      body: "BikeFiesta - Your code is " + code
    )
  end
end