class RemoveCategoryColumnFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :category
  end
end
