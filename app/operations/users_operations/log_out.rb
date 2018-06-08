module Simple
  class LogOut < Operation

    def initialize(token)
      @token = token
    end

    def call
      @token = Token.find_by!(token: authorization_token)
      error! 'Server error.', 500 unless @token
      error! 'Deletion unsuccessful', 500 unless @token.destroy
      { token: @token[:token] }
    end
  end
end