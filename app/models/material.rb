class Material < ApplicationRecord
  validates_uniqueness_of :name
end
