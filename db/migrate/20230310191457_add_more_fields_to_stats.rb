class AddMoreFieldsToStats < ActiveRecord::Migration[6.1]
  def change
    add_column :stats, :user_id, :integer
    add_column :stats, :user_views, :integer
    add_column :stats, :followers, :integer
    add_column :stats, :following, :integer
    add_column :stats, :user_posts, :integer
    add_column :stats, :user_revenue, :float
  end
end
