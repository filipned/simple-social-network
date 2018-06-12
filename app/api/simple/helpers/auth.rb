module Simple
  module Helpers
    module Auth
      def authorization_token
        headers['Authorization'].gsub(/^Bearer\s/, '')
      end

      def authorized?
        return false unless headers['Authorization']
        Token.exists?(token: authorization_token)
      end

      def current_user
        @user ||= Token.find_by(token: authorization_token).user
      end
    end
  end
end