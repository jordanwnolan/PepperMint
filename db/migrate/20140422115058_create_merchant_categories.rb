class CreateMerchantCategories < ActiveRecord::Migration
  def change
    create_table :merchant_categories do |t|
      t.integer :merchant_category_code
      t.string :merchant_category
      
      t.timestamps
    end
  end
end
