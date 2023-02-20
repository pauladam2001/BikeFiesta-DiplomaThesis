class RenamePostColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :notification_sent
    add_column :posts, :leave_review_notification_sent, :boolean, default: false
  end
end
