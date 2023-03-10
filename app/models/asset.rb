class Asset < ApplicationRecord
  has_one_attached :image
  belongs_to :post, foreign_key: :post_id   # maybe counter_cache
  belongs_to :user, foreign_key: :user_id
end
