module FriendshipsOperations
  class PendingRequests < Operation

    def initialize(current_user)
      @current_user = current_user
    end

    def call
      pending_requests = @current_user.left_user_associations.reload.where(state: "PENDING").all
      raise OperationException unless pending_requests
      pending_requests
    end
  end
end