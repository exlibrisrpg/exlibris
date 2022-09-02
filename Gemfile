source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.6"

gem "acts_as_list", "~> 1.0"
gem "avo"
gem "aws-sdk-s3", require: false
gem "bootsnap", ">= 1.4.4", require: false
gem "cssbundling-rails"
gem "clearance"
gem "faraday"
gem "friendly_id"
gem "geared_pagination"
gem "inline_svg"
gem "jbuilder", "~> 2.11"
gem "jsbundling-rails"
gem "meta-tags"
gem "pg", "~> 1.4"
gem "puma", "~> 5.6"
gem "rails", "~> 7.0.3"
gem "skylight"
gem "sprockets-rails", "~> 3.4"
gem "tailwindcss-rails", "~> 2.0"
gem "turbo-rails"
gem "view_component", require: "view_component/engine"

# Explicitly require the net-http gem to silence 'already initialized constant'
# warnings
gem "net-http"

group :production do
  gem "barnes"
  gem "dalli"
  gem "sentry-ruby"
  gem "sentry-rails"
end

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "faker", "~> 2.23"
end

group :development do
  gem "listen", "~> 3.7"
  gem "lookbook"
  gem "rack-mini-profiler", "~> 3.0"
  gem "spring"
  gem "stackprof"
  gem "standard"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "cuprite"
  gem "rails-controller-testing"
  gem "rails_anonymous_controller_testing"
  gem "shoulda-context"
  gem "shoulda-matchers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
