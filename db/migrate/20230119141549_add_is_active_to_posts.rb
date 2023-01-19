class AddIsActiveToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :is_active, :boolean, default: false
  end
end
