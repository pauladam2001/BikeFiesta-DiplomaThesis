class AddNewFieldsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :sold_date, :datetime
  end
end
