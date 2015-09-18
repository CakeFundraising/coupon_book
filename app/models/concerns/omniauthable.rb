module Omniauthable
  extend ActiveSupport::Concern

  module ClassMethods
    ### OmniAuth registration ###
    def find_user_from(auth)
      where(provider: auth.provider, uid: auth.uid).first
    end

    def new_with(auth, params)
      u = if params.blank? and auth.present?#only auth present
        new(first_name: auth.info.first_name || first_name(auth.info.name), 
            last_name: auth.info.last_name || last_name(auth.info.name), 
            email: auth.info.email,
            auth_token: auth.credentials.token,
            auth_secret: auth.credentials.secret,
            provider: auth.provider,
            uid: auth.uid)
      elsif auth.present? and params.present? #both present
        new(params.merge(
              auth_token: auth.credentials.token,
              auth_secret: auth.credentials.secret,
              provider: auth.provider,
              uid: auth.uid
            ))
      else #only params present
        new(params)
      end
      u
    end

    def first_name(full_name)
      full_name.split(' ')[0...-1].join(' ')
    end

    def last_name(full_name)
      full_name.split(' ').last
    end
  end
end