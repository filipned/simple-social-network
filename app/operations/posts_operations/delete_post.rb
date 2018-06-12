module PostsOperations
  class DeletePost

    def initialize(id)
      @id = id
    end

    def call
      post = Post.find_by!(id: @id)
      post.destroy!
      post
    end
  end
end
