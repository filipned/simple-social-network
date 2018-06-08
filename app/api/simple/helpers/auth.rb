module Simple
  module Helpers
    module Auth
      def generate_token
        SecureRandom.base64(32)
      end

      def authorization_token
        headers['Authorization'].gsub(/^Bearer\s/, '')
      end

      def authorized?
        Token.exists?(token: authorization_token)
      end

      def current_user
        Token.find_by(token: authorization_token).user
      end
    end
  end
end