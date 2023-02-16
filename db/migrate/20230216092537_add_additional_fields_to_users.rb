class AddAdditionalFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :card_name, :string
    add_column :users, :card_iban, :string
  end
end
