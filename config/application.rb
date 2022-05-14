require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Exlibris
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    config.eager_load_paths << Rails.root.join("lib")

    # Dump schema as sql so we get language configurations
    config.active_record.schema_format = :sql

    # Opt out of Google's shitty FLoC tracking
    config.action_dispatch.default_headers["Permissions-Policy"] = "interest-cohort=()"

    config.generators do |g|
      g.stylesheets false
    end

    config.session_store :cookie_store, key: "_exlibrisrpg_session", domain: {
      production: ".exlibrisrpg.com",
      development: [".exlibrisrpg.test", "localhost"],
      test: [".example.com", "localhost"]
    }.fetch(Rails.env.to_sym, :all), tld_length: 2
  end
end
