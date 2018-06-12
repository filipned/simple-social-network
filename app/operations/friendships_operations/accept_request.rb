module FriendshipsOperations
  class AcceptRequest < Operation

    def initialize(current_user, request_initiator_id)
      @current_user = current_user
      @request_initiator_id = request_initiator_id
    end

    def call
      friendship = @current_user.right_user_associations.find_by!(left_user_id: @request_initiator_id)
      friendship.update_attributes!(state: "FRIENDS")
      friendship
    end
  end
end
