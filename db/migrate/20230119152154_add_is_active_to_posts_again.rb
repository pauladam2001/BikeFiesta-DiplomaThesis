class AddIsActiveToPostsAgain < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :is_active, :integer, default: 0
  end
end
