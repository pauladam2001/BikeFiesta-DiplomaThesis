class AddLastReadAtToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :last_read_at, :datetime
  end
end
