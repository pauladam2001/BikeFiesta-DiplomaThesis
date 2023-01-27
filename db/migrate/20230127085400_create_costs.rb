class CreateCosts < ActiveRecord::Migration[6.1]
  def change
    create_table :costs do |t|
      t.float :amount
      t.text :description

      t.timestamps
    end
  end
end
