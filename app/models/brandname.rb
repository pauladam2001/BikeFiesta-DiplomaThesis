class Brandname < ApplicationRecord
  validates_uniqueness_of :name
  validates :name, presence: true
end
