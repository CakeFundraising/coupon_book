config = Rails.root.join('config', 'redis_browser.yml')
settings = YAML.load(ERB.new(IO.read(config)).result)
RedisBrowser.configure(settings)

if Rails.env.production?
  RedisBrowser::Web.class_eval do
    use Rack::Auth::Basic, "Protected Area" do |user, password|
      user == ENV["CAKE_RESQUE_SERVER_USER"] && password == ENV["CAKE_RESQUE_SERVER_PASS"]
    end
  end
end