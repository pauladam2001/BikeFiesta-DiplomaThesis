class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  VALID_PASSWORD_REGEX = /\A
    (?=.{6,})     # at least 6 characters long
    (?=.*\d)      # contains at least 1 digit
    (?=.*[a-z])   # contains at least 1 lowercase letter
    (?=.*[A-Z])   # comtains at least 1 uppercase letter
  /x

  validates :first_name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :password, format: VALID_PASSWORD_REGEX

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
      # user.skip_confirmation!
    end
  end

  def name
    if self.full_name.present?
      return full_name
    else
      return [self.first_name, self.last_name].compact.join(" ")
    end
  end

  def is_admin?
    self.user_type == "admin"
  end

  def is_normal?
    self.user_type == "normal"
  end
end
