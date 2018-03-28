class UsersController < ApplicationController

	before_action :Unauthenticated, except: [:log_out, :index]

	def index
	  @current_user = User.where("username = ?", session[:user]).first
		@associated = @current_user.allAssociations
    @users = User.all - [[@associated] + [@current_user]].flatten

    @pendingRequests = @current_user.left_user_associations.reload.where(:state => "PENDING").all
    @pendingAnswers = @current_user.right_user_associations.reload.where(:state => "PENDING").all
    @friends = Friendship.stateFriends.where("left_user_id = ? OR right_user_id = ?", @current_user[:id], @current_user[:id])

  end

	def new

	end



	def create
		@user = User.new(user_params)

		if User.exists?(username: params[:username])
			render 'new'
		else
			if @user.save
				redirect_to log_in_view_path
			else 
				render 'new'
			end
		end
	end


	def log_in_view

	end

	def log_in

		@user = User.where("username = ? AND password = ?", params[:username], params[:password]).first
		
		if @user != nil
			session[:user] = params[:username]
			redirect_to posts_path
			return
		end

		redirect_to log_in_view_path
	end

	def log_out
		# session[:user] = nil
		reset_session
		redirect_to log_in_view_path
	end

	private def user_params
		params.require(:user).permit(:username, :password)
	end

	private def Unauthenticated
		if session[:user]
			redirect_to posts_path
		end
	end
end
