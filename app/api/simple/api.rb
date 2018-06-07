class Simple::API < Grape::API
  mount Simple::PostApi
  mount Simple::CommentApi
end