class AddSolvedToReports < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :solved, :boolean, default: false
  end
end
