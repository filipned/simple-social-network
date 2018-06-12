module Simple
  class PostApi < API

    before do
      error! 'Access denied.', 401 unless authorized?
    end

    desc 'Get all posts.'
    resources :posts do
      desc 'Get all posts.'
      get do
        PostsOperations::ListPosts.call
      end

      desc 'Get post by id.'
      params do
        requires :id, type: String
      end

      route_param :id do
        get do
          Post.find_by(id: params[:id])
        end
      end

      desc 'Create new post..'
      params do
        requires :title, type: String
        requires :body, type: String
      end

      post do
        PostsOperations::CreatePost.call(current_user, params[:title], params[:body])
      end

      desc 'Update a post.'
      params do
        requires :id, type: String
        optional :title, type: String
        optional :body, type: String
      end
      route_param :id do
        put do
          PostsOperations::UpdatePost.call(params[:id], params[:title], params[:body])
        end
      end

      desc 'Delete a post.'
      params do
        requires :id, type: String
      end
      delete :id do
        res = PostsOperations::DeletePost.call(params[:id])
        present res, with: Post
      end
    end
  end
end