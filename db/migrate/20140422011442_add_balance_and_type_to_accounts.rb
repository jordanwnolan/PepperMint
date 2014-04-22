class AddBalanceAndTypeToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :balance, :integer
    add_column :accounts, :account_type, :integer
  end
end
