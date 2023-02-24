class AddSalePercentagetoPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :sale_percentage, :float
  end
end
