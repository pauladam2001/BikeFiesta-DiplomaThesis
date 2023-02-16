class AddFirstPostToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_post, :boolean, default: true
  end
end
