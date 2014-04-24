class CreateFames < ActiveRecord::Migration
  def change
    create_table :fames do |t|
      t.integer :value
      t.integer :user_giving_fame_id
      t.integer :user_receiving_fame_id
      t.references :fameable, polymorphic: true

      t.timestamps
    end

    add_index :fames, :user_receiving_fame_id
    add_index :fames, :user_giving_fame_id
  end
end
