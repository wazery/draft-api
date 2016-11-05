Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ ENV['REDIS_SERVICE_HOST'] }:#{ ENV['REDIS_SERVICE_PORT'] }/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ ENV['REDIS_SERVICE_HOST'] }:#{ ENV['REDIS_SERVICE_PORT'] }/0" }
end
