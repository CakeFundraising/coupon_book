module Cake::Oauth
  APP_ID = ENV['DOORKEEPER_APP_ID'] || '5cdb5507dc11f938b341cb9f81baea22829b5dddd2ba00aaca7a7ac465c76a03'
  APP_SECRET = ENV['DOORKEEPER_APP_SECRET'] || '246a664471dcfb2edcc771c6c8463bd4036733607c6069a4e78b8350af2dff5a'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cake, Cake::Oauth::APP_ID, Cake::Oauth::APP_SECRET
end