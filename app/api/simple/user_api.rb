module Simple
  class UserApi < API

    desc 'Log in.'
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post :log_in do
      error! 'Already signed in.', 208 if authorized?
      UsersOperations::LogIn.call(params[:username], params[:password])
    end

    desc 'Log out.'
    delete :log_out do
      error! 'Access denied.', 401 unless authorized?
      UsersOperations::LogOut.call(authorization_token)
    end


    resources :users do
      desc 'Get all users.'
      get do
        error! 'Access denied.', 401 unless authorized?
        UsersOperations::ListUsers.call(current_user)
      end

      desc 'Register new user.'
      params do
        requires :username, type: String
        requires :password, type: String
      end
      post do
        UsersOperations::CreateUser.call(params[:username], params[:password])
      end
    end
  end
end