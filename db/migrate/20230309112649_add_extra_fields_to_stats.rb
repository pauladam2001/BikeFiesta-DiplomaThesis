class AddExtraFieldsToStats < ActiveRecord::Migration[6.1]
  def change
    add_column :stats, :validating_posts, :integer
    add_column :stats, :banned_posts, :integer
    add_column :stats, :active_posts, :integer
    add_column :stats, :sold_not_shipped_posts, :integer
    add_column :stats, :sold_shipped_posts, :integer
  end
end
