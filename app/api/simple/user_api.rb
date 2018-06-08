module Simple
  class UserApi < API
    # TODO Implement presenting responses using Grape entities
    before do

    end

    desc 'Log in.'
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post :log_in do
      LogIn.call(params[:username], params[:password])
    end

    desc 'Log out.'
    delete '/log_out' do
      error! 'Access denied.', 401 unless authorized?
      LogOut.call(authorization_token)
    end


    resources :users do
      desc 'Get all users.'
      get do
        error! 'Access denied.', 401 unless authorized?
        ListUsers.call
      end

      desc 'Register new user.'
      params do
        requires :username, type: String
        requires :password, type: String
      end
      post do
        CreateUser.call(params[:username], params[:password])
      end
    end
  end
end