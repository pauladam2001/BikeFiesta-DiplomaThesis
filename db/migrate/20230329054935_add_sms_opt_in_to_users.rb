class AddSmsOptInToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :sms_opt_in, :boolean, default: false
  end
end
