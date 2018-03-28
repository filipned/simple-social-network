class AddUniqueConstraint < ActiveRecord::Migration[5.0]
  def change
    add_index :friendships, [:left_user_id, :right_user_id], :unique => true
  end
end
