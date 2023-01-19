class AddUserIdToAssets < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :user_id, :integer
  end
end
