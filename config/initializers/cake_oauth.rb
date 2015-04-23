if Rails.env.test?
  require Rails.root.join('spec', 'support', 'cake_oauth_faker')
else

  module Cake
    module Oauth

      APP_ID = ENV['DOORKEEPER_APP_ID']
      APP_SECRET = ENV['DOORKEEPER_APP_SECRET']
      PROVIDER_HOST = ENV['CAKE_HOST']

      class ErrorDecorator
        attr_accessor :error, :klass

        def initialize(error)
          @error = error
          @klass = error.class.name
        end

        def message
          if @klass == 'OAuth2::Error' and @error.code.present?
            case @error.code
            when 'invalid_grant'
              I18n.t('flash.auth.failed.invalid_grant')
            else
              I18n.t('flash.error.default')
            end
          else
            Rails.logger.error("Cake Auth Error: #{@error.message}")
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
          rescue Exception => e
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