class CreateBrandnames < ActiveRecord::Migration[6.1]
  def change
    create_table :brandnames do |t|
      t.string :name

      t.timestamps
    end
  end
end
