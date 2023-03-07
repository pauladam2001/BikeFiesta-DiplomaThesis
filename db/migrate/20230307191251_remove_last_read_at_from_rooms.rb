class RemoveLastReadAtFromRooms < ActiveRecord::Migration[6.1]
  def change
    remove_column :rooms, :last_read_at, :datetime
  end
end
