class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :post_id
      t.integer :notified_id

      t.timestamps
    end
  end
end
