class AddAdditionalFieldsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :size, :string
    add_column :posts, :category_id, :integer
    add_column :posts, :material_id, :integer
    add_column :posts, :condition, :string
    add_column :posts, :component_group_id, :integer
    add_column :posts, :electric, :boolean
  end
end
