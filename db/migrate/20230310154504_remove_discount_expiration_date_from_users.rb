class RemoveDiscountExpirationDateFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :discount_expiration_date, :datetime
  end
end
