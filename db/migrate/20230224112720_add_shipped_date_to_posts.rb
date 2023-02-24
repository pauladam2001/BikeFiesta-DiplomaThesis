class AddShippedDateToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :shipped_date, :datetime
  end
end
