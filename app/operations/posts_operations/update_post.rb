module PostsOperations
  class UpdatePost < Operation

    def initialize(id, title, body)
      @id = id
      @title = title
      @body = body
    end

    def call
      post = Post.find_by(id: @id)
      post.update!(title: @title, body: @body)
      post.reload
    end
  end
end
