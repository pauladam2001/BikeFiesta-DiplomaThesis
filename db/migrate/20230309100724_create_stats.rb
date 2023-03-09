class CreateStats < ActiveRecord::Migration[6.1]
  def change
    create_table :stats do |t|
      t.datetime :analysis_start_time
      t.datetime :analysis_end_time
      t.date :end_date
      t.float :total_revenue
      t.float :total_spent
      t.float :total_profit
      t.float :roi
      t.integer :total_views
      t.integer :total_posts
      t.integer :total_transactions

      t.timestamps
    end
  end
end
