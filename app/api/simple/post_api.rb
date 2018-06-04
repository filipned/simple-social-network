module Simple
  class PostApi < Grape::API
    prefix :api
    version :v1
    format :json

    helpers {

    }

    # /api/v1/posts
    resources :posts do
      get do
        posts = Post.all
        present posts, with: Simple::Entities::Post
      end

      # /api/v1/posts/:id
      get ':id' do
        Post.first(params[:id])
      end

      params do
        requires :post, type: Hash do
          requires :title, type: String
          requires :body, type: String
        end
      end
      # /api/v1/posts
      post do
        @post = Post.new(params)
        @user = User.where("username = ?", session[:user]).first
        @user.posts.create(params)
      end
    end
  end
end