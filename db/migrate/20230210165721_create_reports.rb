class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :message
      t.string :title

      t.timestamps
    end
  end
end
