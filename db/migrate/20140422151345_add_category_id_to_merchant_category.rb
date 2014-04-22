class AddCategoryIdToMerchantCategory < ActiveRecord::Migration
  def change
    add_column :merchant_categories, :transaction_category_id, :integer
    add_index :merchant_categories, :transaction_category_id
  end
end
