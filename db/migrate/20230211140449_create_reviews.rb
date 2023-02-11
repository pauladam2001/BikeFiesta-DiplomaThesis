class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id
      t.integer :reviewed_id
      t.text :message
      t.integer :grade

      t.timestamps
    end
  end
end
