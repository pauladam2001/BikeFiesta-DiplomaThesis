class AddIsBicycleToAssets < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :is_bicycle, :boolean, default: false
  end
end
