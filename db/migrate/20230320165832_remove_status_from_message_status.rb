class RemoveStatusFromMessageStatus < ActiveRecord::Migration[6.1]
  def change
    remove_column :message_statuses, :status, :string
  end
end
