class CreateRevenues < ActiveRecord::Migration[6.1]
  def change
    create_table :revenues do |t|
      t.float :amount
      t.integer :post_id

      t.timestamps
    end
  end
end
