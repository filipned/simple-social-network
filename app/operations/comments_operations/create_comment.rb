module CommentsOperations
  class CreateComment < Operation

    def initialize(id, body)
      @id = id
      @body = body
    end

    def call
      post = Post.find(@id)
      post.comments.create(comment_params)
    end
  end
end