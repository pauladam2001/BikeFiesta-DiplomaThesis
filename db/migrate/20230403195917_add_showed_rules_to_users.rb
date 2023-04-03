class AddShowedRulesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :showed_rules, :boolean, default: false
  end
end
