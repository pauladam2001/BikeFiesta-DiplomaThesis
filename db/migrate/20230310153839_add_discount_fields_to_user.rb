class AddDiscountFieldsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :discount, :float
    add_column :users, :discount_expiration_date, :datetime
  end
end
