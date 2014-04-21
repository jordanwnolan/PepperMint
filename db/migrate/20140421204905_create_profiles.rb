class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :age
      t.integer :gender
      t.integer :zip_code
      t.string :secondary_email
      t.string :picture_url
      t.integer :user_id

      t.timestamps
    end

    add_index :profiles, :user_id, unique: true
  end
end
