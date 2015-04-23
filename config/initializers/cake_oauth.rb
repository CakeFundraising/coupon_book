if Rails.env.test?
  require Rails.root.join('spec', 'support', 'cake_oauth_faker')
else

  module Cake
    module Oauth

      APP_ID = ENV['DOORKEEPER_APP_ID'] || '5cdb5507dc11f938b341cb9f81baea22829b5dddd2ba00aaca7a7ac465c76a03'
      APP_SECRET = ENV['DOORKEEPER_APP_SECRET'] || '246a664471dcfb2edcc771c6c8463bd4036733607c6069a4e78b8350af2dff5a'
      PROVIDER_HOST = ENV['CAKE_HOST'] || 'http://localhost:3000'

      class ErrorDecorator
        attr_accessor :error

        def initialize(error)
          @error = error
        end

        def message
          case @error.code
          when 'invalid_grant'
            I18n.t('flash.auth.failed.invalid_grant')
          else
            I18n.t('flash.error.default')
          end
        end
      end

      class OauthClient
        attr_accessor :client

        def initialize(blah)
          @client = OAuth2::Client.new(APP_ID, APP_SECRET, site: PROVIDER_HOST)
        end
      end

      class Session < OauthClient
        attr_accessor :email, :password, :client

        def initialize(credentials)
          super
          @email = credentials[:email]
          @password = credentials[:password]
        end

        def authenticate!
          begin
            {granted: true, token: get_token, error: nil}
          rescue OAuth2::Error => e
            {granted: false, token: nil, error: ErrorDecorator.new(e).message}
          end
        end
        
        def get_user
          @access_token.get('api/v1/users/me').parsed
        end

        private

        def get_token
          @client.password.get_token(@email, @password).token
        end
      end

      class Dispatcher < OauthClient
        attr_accessor :model, :flat_access_token

        def initialize(access_token)
          super
          @flat_access_token = access_token
          @access_token = OAuth2::AccessToken.new(@client, @flat_access_token)
        end
      end


      class User < Dispatcher
        def initialize(access_token)
          super(access_token)
        end

        def self
          @access_token.get('api/v1/users/me').parsed
        end
      end

      class Fundraiser < Dispatcher
        def initialize(access_token)
          super(access_token)
        end

        def find(id)
          @access_token.get("api/v1/fundraisers/#{id}").parsed
        end
      end

      class Sponsor < Dispatcher
        def initialize(access_token)
          super(access_token)
        end

        def find(id)
          @access_token.get("api/v1/sponsors/#{id}").parsed
        end
      end

    end
  end
  
end