class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :body, null: false
      t.integer :receiver_id
      t.integer :sender_id

      t.timestamps
    end

    add_index :messages, :receiver_id
    add_index :messages, :sender_id
  end
end
