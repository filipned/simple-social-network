class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships, id:false do |t|
      t.integer :left_user_id
      t.integer :right_user_id
      t.timestamps
    end
  end
end
