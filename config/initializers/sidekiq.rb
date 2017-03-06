require_relative "redis"

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_PROVIDER"] }

  config.timed_fetch! # https://github.com/mperham/sidekiq/wiki/Pro-Reliability-Server
  config.reliable_scheduler! # https://github.com/mperham/sidekiq/wiki/Reliability#scheduler

  database_url = ENV["DATABASE_URL"]
  if database_url.present?
    ENV["DATABASE_URL"] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_PROVIDER"] }
end

Sidekiq.default_worker_options = { "backtrace" => true }
Sidekiq::Client.reliable_push! unless Rails.env.test? # https://github.com/mperham/sidekiq/wiki/Pro-Reliability-Client
Sidekiq::Enterprise.unique! unless Rails.env.test? # https://github.com/mperham/sidekiq/wiki/Ent-Unique-Jobs
