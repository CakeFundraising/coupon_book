source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '4.2.1'
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

#JS
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

#Authentication
gem 'oauth2'

#User permissions
gem 'cancancan'

group :development do
  gem 'quiet_assets'
  gem 'thin'
end

#Utils
gem 'american_date'
gem 'jquery-validation-rails'
gem 'acts_as_list'

#Admin panel
gem 'inherited_resources', github: 'josevalim/inherited_resources'

#Test related
gem 'database_cleaner'
gem 'faker'

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
end

group :production do
  gem 'unicorn'
  gem 'unicorn-worker-killer'
  gem 'rails_12factor'
end

