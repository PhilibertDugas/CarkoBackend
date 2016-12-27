url = ENV.fetch('REDIS_URL', 'redis://localhost:6379')
$redis = Resque.redis = Redis.new(url: url)
