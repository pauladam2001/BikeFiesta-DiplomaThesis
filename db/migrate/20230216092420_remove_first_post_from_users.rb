class RemoveFirstPostFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :first_post
  end
end
