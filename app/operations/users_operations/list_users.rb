module Simple
  class ListUsers < Operation

    def initialize
      @current_user = current_user
    end

    def call
      @current_user = User.where("username = ?", session[:user]).first
      @associated = @current_user.allAssociations
      @users = User.all - [[@associated] + [@current_user]].flatten

      @pendingRequests = @current_user.left_user_associations.reload.where(:state => "PENDING").all
      @pendingAnswers = @current_user.right_user_associations.reload.where(:state => "PENDING").all
      @friends = Friendship.stateFriends.where("left_user_id = ? OR right_user_id = ?", @current_user[:id], @current_user[:id])
    end
  end
end
