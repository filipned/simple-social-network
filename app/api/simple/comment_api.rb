module Simple
  class CommentApi < Grape::API
    prefix :api
    version :v1
    format :json

    resource :posts
    route_param :post_id do
      resource :comments do
        desc 'Create comment on post.'
        params do
          requires :body, type: String
        end
        post :id do
          @post = Post.find(params[:post_id])
          @post.comments.create(params)
        end

        desc 'Delete comment.'
        params do
          requires :id, type: String
        end
        post '/:id' do
          @post = Post.find(params[:post_id])
          @post.comments.create(params)
        end
      end
    end
  end
end