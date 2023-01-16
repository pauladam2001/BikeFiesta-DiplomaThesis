class Asset < ApplicationRecord
  has_one_attached :image
  belongs_to :post, foreign_key: :post_id
end
