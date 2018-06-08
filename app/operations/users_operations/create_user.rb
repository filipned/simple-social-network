module Simple
  class CreateUser < Operation

    def initialize(username, password)
      @username = username
      @password = password
    end

    def call
      user = User.new(user_params)
      error! 'Already exists.', 208 if User.exists?(username: @username)
      error! 'Problem saving.', 500 unless user.save
    end

    private
    def user_params
      params.require(:user).permit(:username, :password)
    end
  end
end