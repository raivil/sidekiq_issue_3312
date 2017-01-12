require "connection_pool"

redis_url = "redis://localhost:6379/"

ENV["REDIS_PROVIDER"] ||= ENV["REDIS_PROVIDER"].presence || redis_url

class Redis
  def self.connection_pool=(connection_pool)
    @@connection_pool = connection_pool
  end

  def self.connection_pool
    @@connection_pool
  end
end
Redis.connection_pool = ConnectionPool.new(size: 30, timeout: 5) do
  Redis::Namespace.new(:redis_pool, redis: Redis.new(url: ENV["REDIS_PROVIDER"], driver: :hiredis))
end
