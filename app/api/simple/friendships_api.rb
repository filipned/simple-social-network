module Simple
  class FriendshipsApi < Grape::API
    prefix :api
    version :v1
    format :json


    resources :friendships do

      get do

      end

      post do

      end

      put 'accept' do

      end

      delete 'destroy' do

      end
    end
  end
end