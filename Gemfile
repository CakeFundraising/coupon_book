source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.3'
gem 'turbolinks', '~> 2.5.3'

#Assets
gem 'sass-rails', '~> 5.0.1'
gem 'uglifier', '~> 2.6.1'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails', '~> 4.0.3'
gem 'jquery-ui-rails'
gem 'therubyracer', platforms: :ruby
gem 'jbuilder'
gem 'zeroclipboard-rails', '~> 0.1.0'
gem 'modernizr-rails', '~> 2.7.1'
gem 'font_assets'

#ReactJS
gem 'browserify-rails'

#JS
gem 'rails-timeago'
gem 'bootstrap-datepicker-rails', '~> 1.3.0.2'

#Views
gem 'slim'
gem 'slim-rails'
gem 'bootstrap-sass', '~> 3.3.4.1'
gem 'font-awesome-sass'
gem 'formtastic'
gem 'formtastic-bootstrap', github: 'mjbellantoni/formtastic-bootstrap'
gem 'draper'
gem 'kaminari'
gem 'bootstrap-kaminari-views'

#Storage
gem 'pg'
gem 'ohm'
gem 'redis-rails'

#Solr
gem 'sunspot_rails'
gem 'sunspot_solr'

#Cron & Asynchronous tasks
gem 'resque', '~> 1.25.2', require: 'resque/server'
gem 'resque-retry'
gem 'resque_mailer'
gem 'resque-scheduler'

#Image processing
gem 'jcrop-rails-v2'
gem 'cloudinary'

#Payments
gem 'stripe-rails'

#CLI
gem 'pry-rails'

#Utils
gem 'prawn'
gem 'money-rails'
gem 'carmen-rails'
gem 'rqrcode'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'roadie-rails'
gem 'metamagic'
gem 'deep_cloneable', require: false
gem 'roo', '~> 2.1.0', require: false
gem 'mail_form'

#Slugs
gem 'friendly_id', '~> 5.1.0'

#Authentication
gem 'oauth2'

#API
gem 'rest-client'

#User registration
gem 'devise'

# Omniauth gems
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-stripe-connect'
# gem 'omniauth-linkedin-oauth2'

#User permissions
gem 'cancancan'

#Browser Fingerprinting
gem 'fingerprintjs-rails'

#App performance
gem 'newrelic_rpm'

group :development do
  gem 'quiet_assets'
  gem 'thin'
  gem 'meta_request'
end

#Utils
gem 'american_date'
gem 'jquery-validation-rails'
gem 'acts_as_list'
gem 'high_voltage'

#Admin panel
gem 'activeadmin', github: 'activeadmin'
gem 'inherited_resources', github: 'josevalim/inherited_resources'

#Test related
gem 'database_cleaner'
gem 'faker'

#API
gem 'grape'
gem 'wine_bouncer'
gem 'grape-swagger'
gem 'swagger-ui_rails'
gem 'api-pagination'
gem 'grape-jbuilder'
gem 'kramdown'

group :doc do
  gem 'sdoc', require: false
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'callback_skipper'
  gem 'byebug'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'sunspot_test'
  gem 'pickle'
  gem 'capybara'
  gem 'webmock'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'shoulda-matchers', require: false
  gem 'launchy'
  gem 'stripe-ruby-mock', require: 'stripe_mock'
end

group :production do
  gem 'unicorn'
  gem 'unicorn-worker-killer'
  gem 'rails_12factor'
  gem 'heroku-deflater'
end

