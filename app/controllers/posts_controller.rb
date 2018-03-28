class PostsController < ApplicationController
	
	before_action :auth
	
# root GET    /                         posts#index

	def index
		@user = session[:user]
		@posts = Post.all
	end

# post GET    /posts/:id(.:format)      posts#show

	def show
		@post = Post.find(params[:id])
  end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@user = User.where("username = ?", session[:user]).first

		@user.posts.create(post_params)
		if @post	
			redirect_to @post
		else 
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(post_params)
			redirect_to @post
		else 
			render 'new'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		
		@post.destroy

		redirect_to posts_path
	end

	private	def post_params
		params.require(:post).permit(:title, :body)
	end

	private def auth
		unless session[:user]
			redirect_to log_in_view_path 	
		end

	end

end
