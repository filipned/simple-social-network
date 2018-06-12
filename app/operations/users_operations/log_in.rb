module UsersOperations
  class LogIn < Operation

    def initialize(username, password)
      @username = username
      @password = password
    end

    def call
      user = User.find_by!("username = ? AND password = ?", @username, @password)
      token = generate_token
      raise ActiveRecord::RecordNotSaved unless user.create_token(token: token)
      {access_token: token}
    end

    private
    def generate_token
      SecureRandom.base64(32)
    end
  end
end