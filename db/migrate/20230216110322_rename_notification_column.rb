class RenameNotificationColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :type
    add_column :notifications, :notification_type , :string
  end
end
