class Notification < ApplicationRecord
  belongs_to :post, optional: true, foreign_key: :post_id
  belongs_to :user, foreign_key: :notified_id
end
