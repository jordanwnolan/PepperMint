class MovePictureUrlToUsersTable < ActiveRecord::Migration
  def change
    remove_column :profiles, :picture_url

    add_column :users, :picture_url, :string
  end
end
