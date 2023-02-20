class AddShippedToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :shipped, :boolean, default: false
  end
end
