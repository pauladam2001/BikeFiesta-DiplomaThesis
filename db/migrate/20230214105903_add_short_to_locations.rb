class AddShortToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :short, :string
  end
end
