Sidekiq.configure_server do |config|
  config.redis = {url: ENV.fetch("REDIS_URL")}
end
Sidekiq.configure_client do |config|
  config.redis = {url: ENV.fetch("REDIS_URL")}
end
Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]
