class CommentsController < ApplicationController

	def index
		@post = Post.find(params[:id])
		@comments = @post.comments
	end

	def new
		
	end

	def show
		
	end

	def create
		@post = Post.find(params[:post_id])
		if @post.comments.create(comment_params)
			redirect_to post_path(@post)
		else
			redirect_to posts_path
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		if @comment.destroy
			redirect_to post_path(@post)
		else
			redirect_to posts_path
		end
	end

	private def comment_params
		params.require(:comment).permit(:body)
	end
end
