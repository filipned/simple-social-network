module Auth
    def user
      User.where("username = ?", session[:user]).first
    end
end