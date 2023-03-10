class AddSpentToStats < ActiveRecord::Migration[6.1]
  def change
    add_column :stats, :user_spent, :float
  end
end
