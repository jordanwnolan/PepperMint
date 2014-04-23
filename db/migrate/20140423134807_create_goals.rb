class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.string :name
      t.integer :account_id
      t.integer :account_initial_bal, default: 0
      t.date :goal_date
      t.integer :amount
      t.boolean :private, default: true

      t.timestamps
    end

    add_index :goals, :user_id
    add_index :goals, :account_id
  end
end
