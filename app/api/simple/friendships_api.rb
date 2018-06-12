module Simple
  class FriendshipsApi < API

    before do
      error! 'Access denied.', 401 unless authorized?
    end

    resources :friendships do
      desc 'List all friends for current user.'
      get do
        FriendshipsOperations::ListFriendships.call(current_user)
      end

      desc 'List pending requests for current user.'
      get :pending_requests do
        FriendshipsOperations::PendingRequests.call(current_user)
      end

      desc 'List pending responses for current user.'
      get :pending_responses do
        FriendshipsOperations::PendingResponses.call(current_user)
      end

      desc 'Create friendship request.'
      params do
        requires :request_receiver_id, type: String
      end
      post do
        FriendshipsOperations::FriendshipRequest.call(current_user, params[:request_receiver_id])
      end

      desc 'Accept request.'
      params do
        requires :request_initiator_id, type: String
      end
      put 'accept' do
        FriendshipsOperations::AcceptRequest.call(current_user, params[:request_initiator_id])
      end

      params do
        optional :request_initiator_id, type: String
        optional :request_receiver_id, type: String
        mutually_exclusive :request_receiver_id, :request_initiator_id
      end
      delete 'destroy' do
        FriendshipsOperations::DeleteFriend.call(current_user, params[:request_receiver_id], params[:request_initiator_id])
      end
    end
  end
end