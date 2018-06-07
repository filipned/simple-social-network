module Simple
  class UserApi < Grape::API
    prefix :api
    version :v1
    format :json


    helpers {
      def generate_token
        # provjeriti da li isti postoji u bazi
        SecureRandom.base64(32)
      end
    }

    desc 'Log in.'
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post '/log_in' do
      if Token.where(token: headers['Authorization'].split(' ')[1]).first
        return status 208
      end
      @user = User.where("username = ? AND password = ?", params[:username], params[:password]).first

      if @user != nil
        token = generate_token
        @user.create_token(:token => token)
        {access_token: token}
      else
        error! 'Access Denied', 401
      end
    end

    delete '/log_out' do
      @token = Token.where(token: headers['Authorization'].split(' ')[1]).first
      if @token
        if @token.destroy
          {
              status: 'success',
              token: @token[:token]
          }
        end
      else
        {status: 'fail'}
      end
    end


    resources :users do
      desc 'Get all users.'
      get do

      end
      desc 'Register new user.'
      params do
        requires :username, type: String
        requires :password, type: String
      end
      post do

      end
    end
  end
end