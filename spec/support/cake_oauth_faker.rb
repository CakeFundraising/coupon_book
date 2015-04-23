module Cake
  module Oauth

    class Session
      attr_accessor :email, :password

      def initialize(credentials)
        @email = credentials[:email]
        @password = credentials[:password]
      end
      
      def authenticate!
        if valid_credentials?
          {granted: true, token: SecureRandom.base64(32), error: nil}
        else
          {granted: false, token: nil, error: I18n.t('flash.auth.failed.invalid_grant')}
        end
      end

      private

      def valid_credentials?
        valid_credential = FactoryGirl.attributes_for(:user_credential)
        valid_credential[:email] == @email and valid_credential[:password] == @password
      end
    end

  end
end