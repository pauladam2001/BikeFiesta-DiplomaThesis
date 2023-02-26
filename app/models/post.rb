class Post < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_many :assets
  belongs_to :color, foreign_key: :color_id
  belongs_to :location, foreign_key: :location_id
  belongs_to :brandname, foreign_key: :brandname_id
  belongs_to :category, foreign_key: :category_id
  belongs_to :material, foreign_key: :material_id
  belongs_to :component_group, foreign_key: :component_group_id
  has_many :favorites
  has_many :reports
  has_one :notification
  has_one :purchase

  # is_active: 0 = validating, -1 = banned, 1 = active, -2 = sold & not shipped, -3 = sold & shipped

  attr_accessor :skip_validation

  validates :name, presence: true, length: { minimum: 1, maximum: 20 }, unless: :skip_validation
  validates :description, presence: true, unless: :skip_validation
  validates :short_description, presence: true, length: { minimum: 1, maximum: 100 }, unless: :skip_validation
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 1000000 }
  validates :color_id, presence: true, unless: :skip_validation
  validates :brandname_id, presence: true, unless: :skip_validation
  validates :location_id, presence: true, unless: :skip_validation
  validates :year, presence: true, unless: :skip_validation
  validates :category_id, presence: true, unless: :skip_validation
  validates :size, presence: true, unless: :skip_validation
  validates :condition, presence: true, unless: :skip_validation
  validates :material_id, presence: true, unless: :skip_validation
  validates :component_group_id, presence: true, unless: :skip_validation
  validates :electric, inclusion: { in: [true, false] }, unless: :skip_validation
end
