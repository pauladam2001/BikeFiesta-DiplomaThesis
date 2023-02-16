class AddShippingPaymentFieldsToPurchase < ActiveRecord::Migration[6.1]
  def change
    add_column :purchases, :shipping_details, :text
    add_column :purchases, :payment_details, :text
  end
end
