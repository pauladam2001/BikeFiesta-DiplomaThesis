class RenameTransactionTable < ActiveRecord::Migration[6.1]
  def change
    rename_table :transactions, :purchases
  end
end
