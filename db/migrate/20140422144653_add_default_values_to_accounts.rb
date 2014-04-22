class AddDefaultValuesToAccounts < ActiveRecord::Migration
  def change
    change_column :accounts, :balance, :integer, default: 0
  end
end
