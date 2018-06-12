module Simple
  class CommentApi < API

    before do
      error! 'Access denied.', 401 unless authorized?
    end

    resource :posts
    route_param :post_id do
      resource :comments do
        desc 'Create comment on post.'
        params do
          requires :body, type: String
          requires :body, type: String
        end
        post do
          CommentsOperations::CreateComment.call(params[:post_id], params[:body])
        end

        desc 'Delete comment.'
        params do
          requires :id, type: String
        end
        route_param :id do
          post do
            CommentsOperations::DeleteComment.call(params[:post_id], params[:id])
          end
        end
      end
    end
  end
end