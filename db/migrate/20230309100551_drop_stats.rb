class DropStats < ActiveRecord::Migration[6.1]
  def change
    drop_table :stats
  end
end
