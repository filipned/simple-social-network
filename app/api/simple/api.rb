class Simple::API < Grape::API
  version :v1
  prefix :api
  format :json

  rescue_from ActiveRecord::ActiveRecordError, OperationException, StandardError, Exception do |e|
    error! "Server error: #{e}", 500
  end

  include Simple::Entities

  helpers Simple::Helpers::Auth

  mount Simple::PostApi
  mount Simple::CommentApi
  mount Simple::UserApi
  mount Simple::FriendshipsApi
end