class AddNewFieldsToPurchases < ActiveRecord::Migration[6.1]
  def change
    add_column :purchases, :on_hold, :boolean, default: false
    add_column :purchases, :money_sent_to_seller, :boolean, default: false
  end
end
