class Color < ApplicationRecord
  validates_uniqueness_of :name
end
