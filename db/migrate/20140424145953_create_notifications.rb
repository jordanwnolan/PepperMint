class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :message, null: false
      t.boolean :viewed, default: false
      t.integer :user_id
      t.references :notifiable, polymorphic: true

      t.timestamps
    end

    add_index :notifications, :user_id
  end
end
