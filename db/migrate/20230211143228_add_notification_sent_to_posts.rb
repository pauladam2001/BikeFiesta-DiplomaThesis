class AddNotificationSentToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :notification_sent, :boolean, default: false
  end
end
