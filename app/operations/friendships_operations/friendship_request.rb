module FriendshipsOperations
  class FriendshipRequest < Operation

    def initialize(current_user, request_receiver_id)
      @current_user = current_user
      @request_receiver_id = request_receiver_id
    end

    def call
      raise OperationException if @request_receiver_id == current_user[:id]
      friendship = @current_user.left_user_associations.create(right_user_id: @request_receiver_id, state: "PENDING")
      raise OperationException unless friendship
      friendship
    end
  end
end
