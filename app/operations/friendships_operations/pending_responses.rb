module FriendshipsOperations
  class PendingResponses < Operation

    def initialize(current_user)
      @current_user = current_user
    end

    def call
      pending_responses = @current_user.right_user_associations.reload.where(state: "PENDING").all
      raise OperationException unless pending_responses
      pending_responses
    end
  end
end
