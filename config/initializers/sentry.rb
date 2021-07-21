Sentry.init do |config|
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
end
