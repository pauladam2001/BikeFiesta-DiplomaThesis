class AddCodeExpirationDateToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :code_expiration_date, :datetime
  end
end
