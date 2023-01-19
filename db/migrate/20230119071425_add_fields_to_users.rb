class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :code, :string
    add_column :users, :phone, :string
  end
end
