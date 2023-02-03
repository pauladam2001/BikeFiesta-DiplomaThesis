class ChangeSalePriceToFloatInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :sale_price, 'float USING sale_price::double precision'
  end
end
