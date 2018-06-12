module UsersOperations
  class CreateUser < Operation

    def initialize(username, password)
      @username = username
      @password = password
    end

    def call
      user = User.new(username: @username, password: @password)
      raise OperationException('User already exists') if User.exists?(username: @username)
      user.save!
      user
    end
  end
end