class AddPeriodToStats < ActiveRecord::Migration[6.1]
  def change
    add_column :stats, :period, :string
  end
end
