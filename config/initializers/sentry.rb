if Rails.env.production?
  Sentry.init do |config|
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
    config.environment = ENV.fetch("SENTRY_ENVIRONMENT")
  end
end
