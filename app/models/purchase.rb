class Purchase < ApplicationRecord
  has_one_attached :proof
  belongs_to :seller, foreign_key: :seller_id, class_name: "User"
  belongs_to :buyer, foreign_key: :buyer_id, class_name: "User"
  belongs_to :post, foreign_key: :post_id
  
  # status: "PENDING", "SHIPPED", "NOT_SHIPPED", "REFUNDED"

  serialize :shipping_details
  serialize :payment_details    #TODO here we will need the authorization that the first transaction returns (I think, check)
end
