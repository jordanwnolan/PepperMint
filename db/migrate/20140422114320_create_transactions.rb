class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :account_id
      t.integer :merchant_category_code
      t.text :description
      t.string :category
      t.integer :amount
      t.date :date

      t.timestamps
    end

    add_index :transactions, :account_id
  end
end
