class DropBrandNamesTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :brand_names
  end
end
