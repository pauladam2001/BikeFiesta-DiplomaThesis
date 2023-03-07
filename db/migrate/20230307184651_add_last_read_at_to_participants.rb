class AddLastReadAtToParticipants < ActiveRecord::Migration[6.1]
  def change
    add_column :participants, :last_read_at, :datetime
  end
end
