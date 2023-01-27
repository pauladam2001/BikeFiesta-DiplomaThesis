class CreateStats < ActiveRecord::Migration[6.1]
  def change
    create_table :stats do |t|
      t.datetime :analysis_start_time
      t.datetime :analysis_end_time
      t.integer :total_views
      t.integer :total_posts
      t.float :total_cost
      t.float :total_revenue
      t.float :total_profit
      t.integer :total_transactions
      t.float :roi

      t.timestamps
    end
  end
end
