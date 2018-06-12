module FriendshipsOperations
  class DeleteFriend

    def initialize(current_user, request_receiver_id, request_initiator_id)
      @current_user = current_user
      @request_receiver_id = request_receiver_id
      @request_initiator_id = request_initiator_id
    end

    def call
      if @request_receiver_id == current_user[:id].to_s
        @current_user.right_user_associations.find_by!(left_user_id: @request_initiator_id).destroy!
      end

      if @request_initiator_id == current_user[:id].to_s
        @current_user.left_user_associations.find_by!(right_user_id: @request_receiver_id).destroy!
      end
    end
  end
end