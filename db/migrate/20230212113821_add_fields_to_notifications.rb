class AddFieldsToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :message, :string
  end
end
