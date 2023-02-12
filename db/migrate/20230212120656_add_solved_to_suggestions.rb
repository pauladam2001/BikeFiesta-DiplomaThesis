class AddSolvedToSuggestions < ActiveRecord::Migration[6.1]
  def change
    add_column :suggestions, :solved, :boolean, default: false
  end
end
