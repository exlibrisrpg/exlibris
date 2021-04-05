require_relative "config/application"

Rails.application.load_tasks

if Rails.env.development? || Rails.env.test?
  require "standard/rake"

  task default: :lint

  desc "Lint everything"
  task lint: "lint:ruby"

  namespace :lint do
    desc "Lint the ruby files everywhere"
    task ruby: "standard"
  end
end
