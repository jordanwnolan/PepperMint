class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.integer :user_id, null: false
      t.integer :category_id, null: false
      t.integer :frequency, null: false
      t.integer :frequency_reset
      t.integer :amount, null: false
      t.boolean :private, default: true

      t.timestamps
    end

    add_index :budgets, :user_id
    add_index :budgets, :category_id
  end
end
