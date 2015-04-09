unless Rails.env.test?
  Dir[Rails.root.join('app/jobs/*.rb')].each { |file| require file }

  redis_url = ENV["REDISTOGO_URL"] || "redis://localhost:6379/0/cake"

  CakeCouponBook::Application.config.cache_store = :redis_store, redis_url
  CakeCouponBook::Application.config.session_store :redis_store, redis_server: redis_url
end