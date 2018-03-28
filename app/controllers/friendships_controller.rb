 class FriendshipsController < ApplicationController


  def index
  	@current_user = User.where("username = ?", session[:user]).first
    @pendingRequests = @current_user.left_user_associations.reload.where(:state => "PENDING").all
    @pendingAnswers = @current_user.right_user_associations.reload.where(:state => "PENDING").all
    @friends = Friendship.stateFriends.where("left_user_id = ? OR right_user_id = ?", @current_user[:id], @current_user[:id])
    # @friendships = User.find_by_sql('SELECT "users".* FROM "users" INNER JOIN "friendships" ON "users"."id" = "friendships"."right_user_id" WHERE "friendships"."left_user_id" = ' + @current_user[:id].to_s + ' OR "friendships"."right_user_id" = ' + @current_user[:id].to_s)
  end

  def create
  	@current_user = User.where("username = ?", session[:user]).first
    if params[:right_user_id] == @current_user[:id]
      redirect_to friends_path
      return
    end
    
  	@friendship = @current_user.left_user_associations.build(:right_user_id => params[:right_user_id], :state => "PENDING")
  	if @friendship.save
  		flash[:notice] = "Successfully created friendship"
  		redirect_to friends_path
  	end
  end


  def accept
    @current_user = User.where("username = ?", session[:user]).first
    @friendship = @current_user.right_user_associations.where(:left_user_id => params[:left_user_id]).first

    if @friendship.update_attributes(:state => "FRIENDS")
      redirect_to friends_path
    end
  end

  def destroy
    @current_user = User.where("username = ?", session[:user]).first
    if params[:right_user_id] == @current_user[:id].to_s
      if @current_user.right_user_associations.where(:left_user_id => params[:left_user_id]).first.destroy
        redirect_to friends_path
        return
      end
    end

    if params[:left_user_id] == @current_user[:id].to_s
      if @current_user.left_user_associations.where(:right_user_id => params[:right_user_id]).first.destroy
        redirect_to friends_path
        return
      end
    end
    redirect_to :alert => "Unsuccesful delete"

  end

end
