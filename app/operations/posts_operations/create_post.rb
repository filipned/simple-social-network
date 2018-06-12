module PostsOperations
  class CreatePost < Operation

    def initialize(current_user, title, body)
      @current_user = current_user
      @title = title
      @body = body
    end

    def call
      @current_user.posts.create!(title: @title, body: @body)
      # raise ActiveRecord::RecordNotSaved unless post
    end

  end
end