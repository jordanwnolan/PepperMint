class AddShareIdToFames < ActiveRecord::Migration
  def change
    add_column :fames, :share_id, :integer
  end
end
