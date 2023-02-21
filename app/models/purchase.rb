class Purchase < ApplicationRecord
  has_one_attached :proof
  belongs_to :seller, foreign_key: :seller_id, class_name: "User"
  belongs_to :buyer, foreign_key: :buyer_id, class_name: "User"
  belongs_to :post, foreign_key: :post_id
  
  # status: "AUTHORIZED_NO_PROOF", "AUTHORIZED_PROOF" "CAPTURED", "REFUNDED" #TODO when we refund it we can just delete the purchase, so no need for "REFUNDED"

  serialize :shipping_details
  serialize :payment_details
end
