class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :post_id
      t.float :amount

      t.timestamps
    end
  end
end
