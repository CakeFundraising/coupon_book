require "ohm"
require 'resque-retry'
require 'resque/failure/redis'

# require your jobs & application code.

unless Rails.env.test?
  Dir[Rails.root.join('app/jobs/*.rb')].each { |file| require file }
  
  redis_url = ENV["REDISTOGO_URL"]
  # Ohm
  Ohm.redis = Redic.new(redis_url)

  # Resque
  if Rails.env.development?
    Resque.redis = redis_url
  elsif Rails.env.production?

    uri = URI.parse(ENV["REDISTOGO_URL"])
    Resque.redis = Redis.new(host: uri.host, port: uri.port, password: uri.password, thread_safe: true)

    Resque::Server.use(Rack::Auth::Basic) do |user, password|
      user == ENV["CAKE_RESQUE_SERVER_USER"]
      password == ENV["CAKE_RESQUE_SERVER_PASS"]
    end
  end

  # Cache & Session Store
  CakeCouponBook::Application.config.cache_store = :redis_store, redis_url
  CakeCouponBook::Application.config.session_store :redis_store, redis_server: redis_url

  # Resque Schedule
  Resque.schedule = YAML.load_file(Rails.root.join('config/schedule.yml'))
  
  #Hide duplicated failed jobs
  Resque::Failure::MultipleWithRetrySuppression.classes = [Resque::Failure::Redis]
  Resque::Failure.backend = Resque::Failure::MultipleWithRetrySuppression
end