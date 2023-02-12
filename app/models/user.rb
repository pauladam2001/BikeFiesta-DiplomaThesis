class User < ApplicationRecord
  after_save :update_phone_number_and_name

  attr_accessor :skip_validation
  
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

  validates :first_name, presence: true, length: { minimum: 3, maximum: 25 }, unless: :skip_validation, unless: Proc.new { |u| u.reset_password_token.present? }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 25 }, unless: :skip_validation, unless: Proc.new { |u| u.reset_password_token.present? }
  validates :phone, presence: true, length: { minimum: 9, maximum: 12 }, unless: :skip_validation, unless: Proc.new { |u| u.reset_password_token.present? }
  # validates :password, format: VALID_PASSWORD_REGEX, unless: :skip_validation
  validate :password_regex, unless: :skip_validation

  has_one_attached :avatar
  validates :avatar, :presence => true, unless: :skip_validation, unless: Proc.new { |u| u.reset_password_token.present? }

  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :reports
  has_many :notifications, foreign_key: :notified_id, dependent: :destroy
  has_many :reviews, foreign_key: :reviewed_id, dependent: :destroy
  has_many :suggestions

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create!(skip_validation: true) do |user|
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
    self.role == "admin"
  end

  def is_normal?
    self.role == "normal"
  end

  def self.generate_code(user)
    code = Random.rand.to_s[2..7]
    user.code = code
    user.code_expiration_date = Time.now + 30.minutes
    user.save(validate: false)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def password_regex
    return if password.blank? || password =~ /\A(?=.*\d)(?=.*[A-Z])(?=.*\W)[^ ]{6,}\z/
    errors.add :password, 'should have more than 6 characters including 1 uppercase letter, 1 number, 1 special character'
  end

  def active_for_authentication?
    super and !self.archived
  end

  def update_phone_number_and_name
    if self.full_name.nil?
      self.full_name = [self.first_name, self.last_name].compact.join(" ")
      self.save(validate: false)
    end

    if !self.phone.nil?
      if self.phone&.length == 9
        self.phone = "+40" + self.phone
        self.save(validate: false)
      elsif !self.phone&.start_with?("+40")
        phone = self.phone

        while phone[0] != "0"
          phone = phone[1..-1]
        end
        phone = phone[1..-1]

        self.phone = "+40" + phone
        self.save(validate: false)
      end
    end
  end
end
