module CommentsOperations
  class DeleteComment < Operation

    def initialize(post_id, id)
      @post_id = post_id
      @id = id
    end

    def call
      post = Post.find(@post_id)
      comment = post.comments.find(@id)
      comment.destroy!
    end
  end
end