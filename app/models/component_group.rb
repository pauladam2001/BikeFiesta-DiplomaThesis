class ComponentGroup < ApplicationRecord
  validates_uniqueness_of :name
end
