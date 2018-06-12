module UsersOperations
  class ListUsers < Operation

    def initialize(current_user)
      @current_user = current_user
    end

    def call
      associated = @current_user.allAssociations
      raise ActiveRecord::RecordNotFound unless associated
      User.all - [[associated] + [@current_user]].flatten
    end
  end
end
