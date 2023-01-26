class AddSoldToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :sold, :boolean, default: false
  end
end
