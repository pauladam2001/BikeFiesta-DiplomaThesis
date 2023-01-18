class AddFieldsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :color, :string
    add_column :posts, :year, :integer
    add_column :posts, :location, :string
    add_column :posts, :brand_name, :string
    add_column :posts, :sale_price, :string
    add_column :posts, :sale_price_expiration, :datetime
  end
end
