module Cake::Oauth
  class Session
    attr_accessor :email, :password, :rest_resource

    def initialize(credentials)
      @email = credentials[:email]
      @password = credentials[:password]
    end
    
    def new_session
    end
    
  end
end