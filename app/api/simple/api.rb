class Simple::API < Grape::API
  mount Simple::PostApi
  mount Simple::CommentApi
  mount Simple::UserApi
  mount Simple::FriendshipsApi
end