module Simple
  module OAuth
    class OAuthServer < Grape::API

      # Output: Authorization code or access token, depending on response_type param
      resources :authorize do
        desc 'Starts oauth authorization flow'
        params do
          optional :state, type: String, desc: 'random string used to pair req/response'
          optional :scopes, type: String, desc: 'defines accessible resources'
          requires :response_type, type: String, desc: 'defines type of oauth flow'
          requires :client_id, type: String, desc: 'identifies client'
          requires :redirect_uri, type: String, desc: 'uri of client application(endpoint where response goes)'
        end
        get do
        #   1. Redirect to login page

        #   2. Authenticate user
        #   3. Send consent data
        #   4. Receive and check consent answer
        #   5. Redirect with header Location: redirect_uri?code=nesto&state=nestodrugo
        #   return response to client_uri endpoint
        end
      end

      # Output: Access token and refresh token
      resources :token do
        # in header goes Authorization: Basic {client_id}:{client_secret} base64
        # http://client_id:client_secret@www.server.com/index.html
        params do
          optional :grant_type, type: String, desc: 'define grant type, like user credentials, auth code or res cred'
          optional :code, type: String, desc: 'authorization code created in /authorize endpoint'
          requires :client_id, type: String, desc: 'defines type of oauth flow'
          requires :redirect_uri, type: String, desc: 'uri of client application(endpoint where response goes)'
        end
        post do
        #   1. Authorize validity of authorization code
        #   2. Send back application/json e.g.
        #       {
        #         "access_token":"r23jr0923rj",
        #         "token_type":"Bearer",
        #         "refresh_token":"f2k-0cke2c0k1",
        #         "expires_in":"3600"
        #       }
        end
      end
    end

    desc 'validates access token'
    resources :verify do
      params do
        optional :grant_type, type: String, desc: 'define grant type, like user credentials, auth code or res cred'
        optional :code, type: String, desc: 'authorization code created in /authorize endpoint'
        requires :client_id, type: String, desc: 'defines type of oauth flow'
        requires :redirect_uri, type: String, desc: 'uri of client application(endpoint where response goes)'
      end
      post do
        #   1. Get and verify request from resources server
        #       (question is if access token is valid)
        #   2. Send answer to resources server, with validity
        #       and "I think scopes"
      end
    end
  end
end

# Tokens are stored in database of oauth provider, they are uniqe
# does not contain any encoded user data