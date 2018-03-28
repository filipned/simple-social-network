class AddStateToFriendships < ActiveRecord::Migration[5.0]
  def change
    add_column :friendships, :state, :string
  end
end
