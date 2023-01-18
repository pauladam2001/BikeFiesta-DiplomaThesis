class ChangeColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :locations, :nanme, :name
  end
end
