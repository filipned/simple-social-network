module Simple
  class LogIn < Operation

    def initialize(username, password)
      @username = username
      @password = password
    end

    def call
      error! 'Already signed in.', 208 if authorized?
      @user = User.find_by("username = ? AND password = ?", params[:username], params[:password])
      error! 'Wrong credentials!', 400 if @user.nil?

      token = generate_token
      @user.create_token(token: token)
      {access_token: token}
    end
  end
end