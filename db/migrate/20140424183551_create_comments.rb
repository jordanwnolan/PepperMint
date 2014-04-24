class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :author_id
      t.references :commentable, polymorphic: true

      t.timestamps
    end

    add_index :comments, :author_id
  end
end
