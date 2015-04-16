require "ohm"

unless Rails.env.test?
  redis_url = ENV["REDISTOGO_URL"] || "redis://localhost:6379/"

  CakeCouponBook::Application.config.cache_store = :redis_store, redis_url
  CakeCouponBook::Application.config.session_store :redis_store, redis_server: redis_url

  Ohm.redis = Redic.new(redis_url)
end