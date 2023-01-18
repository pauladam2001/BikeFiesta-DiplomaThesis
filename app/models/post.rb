class Post < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_many :assets
  belongs_to :color, foreign_key: :color_id
  belongs_to :location, foreign_key: :location_id
  belongs_to :brandname, foreign_key: :brandname_id
end
