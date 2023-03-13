class AddIndexesToTables < ActiveRecord::Migration[6.1]
  def change
    add_index :brandnames, :name, unique: true
    add_index :materials, :name, unique: true
    add_index :categories, :name, unique: true
    add_index :colors, :name, unique: true
    add_index :component_groups, :name, unique: true
    add_index :posts, :is_active
    add_index :posts, :user_id
    add_index :posts, :buyer_id
    add_index :posts, [:is_active, :user_id]
    add_index :stats, [:end_date, :period], name: "stats_common_query"
    add_index :costs, [:amount, :description], unique: true
  end
end
