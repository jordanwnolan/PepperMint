class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.string :url

      t.timestamps
    end

    add_index :banks, :name
  end
end
