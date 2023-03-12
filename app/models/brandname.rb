class Brandname < ApplicationRecord
  validates_uniqueness_of :name
end
