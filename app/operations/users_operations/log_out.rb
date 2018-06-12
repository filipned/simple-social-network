module UsersOperations
  class LogOut < Operation

    def initialize(token)
      @token = token
    end

    def call
      token = Token.find_by(token: @token)
      raise OperationException unless token
      token.destroy!
      { token: @token }
    end
  end
end