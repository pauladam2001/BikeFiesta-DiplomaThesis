class AddBuyerIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :buyer_id, :integer
  end
end
