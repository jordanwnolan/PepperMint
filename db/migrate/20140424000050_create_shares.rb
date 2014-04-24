class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.text :message
      t.boolean :status
      t.references :shareable, polymorphic: true
      t.integer :user_id

      t.timestamps
    end

    add_index :shares, :user_id
  end
end
