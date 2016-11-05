require 'redis'

## Added rescue condition if Redis connection is failed
begin
  $redis = Redis.new(:host => ENV['REDIS_SERVICE_HOST'], :port => ENV['REDIS_SERVICE_PORT']) 
rescue Exception => e
  puts e
end
