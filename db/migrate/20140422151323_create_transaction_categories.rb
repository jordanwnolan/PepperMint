class CreateTransactionCategories < ActiveRecord::Migration
  def change
    create_table :transaction_categories do |t|
      t.string :description

      t.timestamps
    end
  end
end
