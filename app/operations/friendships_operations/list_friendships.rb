module FriendshipsOperations
  class ListFriendships < Operation
    def initialize(current_user)
      @current_user = current_user
    end

    def call
      friendships = Friendship.stateFriends.where("left_user_id = ? OR right_user_id = ?", @current_user[:id], @current_user[:id])
      raise ActiveRecord::RecordNotFound unless friendships
      friendships
    end
  end
end
