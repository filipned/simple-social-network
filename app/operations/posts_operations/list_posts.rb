module PostsOperations
  class ListPosts < Operation

    def initialize
    end

    def call
      posts = Post.all
      raise ActiveRecord::RecordNotFound unless posts
      posts
    end
  end
end
