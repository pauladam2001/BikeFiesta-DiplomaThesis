class Post < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_many :assets
  belongs_to :color, foreign_key: :color_id
  belongs_to :location, foreign_key: :location_id
  belongs_to :brandname, foreign_key: :brandname_id

  attr_accessor :skip_validation

  validates :name, presence: true, length: { minimum: 1, maximum: 20 }, unless: :skip_validation
  validates :description, presence: true, unless: :skip_validation
  validates :short_description, presence: true, length: { minimum: 1, maximum: 50 }, unless: :skip_validation
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 1000000 }
  validates :color_id, presence: true
  validates :brandname_id, presence: true
  validates :location_id, presence: true
  validates :year, presence: true
end
