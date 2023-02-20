class ModifyUsersFields < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :card_name
    remove_column :users, :card_iban
    add_column :users, :paypal_email, :string
  end
end
