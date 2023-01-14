class ChangeRoleDefaultValue < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :role, :string, :default => false
  end
end
