module Simple
  module OAuth
    class OAuthClient < Grape::API
    #   receives state, scopes and code created on oauth server
    #   as input of redirect_uri path

      resources :redirect_uri_name do
        params do
          requires :state, type: String, desc: 'Make correlation btw req/res'
          requires :scopes, type: String, desc: 'Resources scopes for which client need access.'
          requires :code, type: String
        end
        get do

        end
      end
    end
  end
end

# Access tokens
#   Access tokens are used to provide access to resources
#   anybody who have AT can access resources
#   This tokens can have expiration time, and are only sent to resources server

# Refresh tokens
#   Refresh tokens are used to regenerate access tokens after expiration,
#   and are never sent to resources server.
#   It is sent to the /token endpoint of ouath server.

# Authorization code
#   Generated from oauth server, and sent to the client, after successfully authenticating
#   resource owner. Validity is limited to a couple of minutes. Never sent to resources
#   provider. It can only be processed by /token endpoint of ouath server.

# Authorization FLOW
#   1. Get authorization code
#   2. Get access and refresh token - grant_type=authorization_code
#     - send request with Authorization: Basic {client_id}:{client_secret} base64
#   3. Use the token for resources access
#     - send request with header Authorization: Bearer "access_token"
#   4. If resources server returns 401 unauthorized send refresh token to
#       /token endpoint to gain new access token
#       grant_type=refresh_token
#      If refresh token also expired than we start process again and call authorize
#       endpoint

# Client credentials FLOW (when resource owner and client are the same)
#   1. When logged in client calls /token endpoint
#   2. Use token for resources access
#