class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id, null: false
      t.integer :bank_id, null: false
      t.string :account_username
      t.string :account_password
      t.string :account_name

      t.timestamps
    end

    add_index :accounts, :user_id
    add_index :accounts, :bank_id
  end
end
