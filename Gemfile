source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "avo"
gem "aws-sdk-s3", require: false
gem "bootsnap", ">= 1.4.4", require: false
gem "cssbundling-rails"
gem "clearance"
gem "friendly_id"
gem "geared_pagination"
gem "inline_svg"
gem "jbuilder", "~> 2.11"
gem "meta-tags"
gem "pg", "~> 1.3"
gem "puma", "~> 5.6"
gem "rails", "~> 7.0.1"
gem "sass-rails", ">= 6"
gem "skylight"
gem "turbo-rails"
gem "view_component", require: "view_component/engine"
gem "webpacker", "~> 5.4"

group :production do
  gem "barnes"
  gem "dalli"
  gem "sentry-ruby"
  gem "sentry-rails"
end

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "brakeman"
  gem "listen", "~> 3.7"
  gem "rack-mini-profiler", "~> 2.3"
  gem "stackprof"
  gem "spring"
  gem "standard"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "rails-controller-testing"
  gem "selenium-webdriver"
  gem "shoulda-context"
  gem "shoulda-matchers"
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
