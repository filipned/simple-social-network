module Simple
  class PostApi < Grape::API

    desc 'Get all posts.'
    resources :posts do
      desc 'Get all posts.'
      get do
        posts = Post.all
        present posts, with: Simple::Entities::Post
      end

      desc 'Get post by id.'
      get ':id' do
        Post.first(params[:id])
      end

      params do
        # requires :post, type: Hash do
          requires :title, type: String
          requires :body, type: String
        # end
      end

      desc 'Create new post..'
      post do
        @post = Post.new(params)
        # @user = User.where("username = ?", session[:user]).first
        @user.posts.create(declared(params))
      end

      desc 'Update a post.'
      params do
        requires :id, type: String
        optional :title, type: String
        optional :body, type: String
      end
      put :id do
        @post = Post.find(params[:id])
        @post.update(declared(params, include_missing: false))
      end

      desc 'Delete a post.'
      params do
        requires :id, type: String
      end
      delete :id do
        @post = Post.find(params[:id])
        @post.destroy
      end
    end
  end
end