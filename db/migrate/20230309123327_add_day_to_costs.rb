class AddDayToCosts < ActiveRecord::Migration[6.1]
  def change
    add_column :costs, :day, :date
  end
end
