class ChangePostFields < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :color
    remove_column :posts, :location
    remove_column :posts, :brand_name
    add_column :posts, :color_id, :integer
    add_column :posts, :location_id, :integer
    add_column :posts, :brandname_id, :integer
  end
end
