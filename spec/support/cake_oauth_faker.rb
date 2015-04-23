module Cake
  module Oauth

    class Session
      attr_accessor :email, :password

      def initialize(credentials)
        @email = credentials[:email]
        @password = credentials[:password]
      end
      
      def access_token
        SecureRandom.base64(32) if valid_credentials?
      end

      private

      def valid_credentials?
        valid_credential = FactoryGirl.attributes_for(:user_credential)
        valid_credential[:email] == @email and valid_credential[:password] == @password
      end
    end

  end
end