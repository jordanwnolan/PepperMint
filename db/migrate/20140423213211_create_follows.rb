class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :follows, :followed_id
    add_index :follows, :follower_id
  end
end
