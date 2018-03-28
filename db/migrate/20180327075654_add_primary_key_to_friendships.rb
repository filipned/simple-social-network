class AddPrimaryKeyToFriendships < ActiveRecord::Migration[5.0]
  def change
    add_column :friendships, :id, :primary_key
  end
end
