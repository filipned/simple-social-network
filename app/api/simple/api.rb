class Simple::API < Grape::API
  version :v1
  prefix :api
  format :json

  helpers Simple::Helpers::Auth

  mount Simple::PostApi
  mount Simple::CommentApi
  mount Simple::UserApi
  mount Simple::FriendshipsApi
end