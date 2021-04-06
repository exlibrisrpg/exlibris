require_relative "config/application"

Rails.application.load_tasks

if Rails.env.development? || Rails.env.test?
  require "standard/rake"

  task default: :lint

  desc "Lint everything"
  task lint: ["lint:ruby", "lint:scss"]

  namespace :lint do
    desc "Lint the ruby files everywhere"
    task ruby: "standard"

    desc "Lint the scss files"
    task :scss do
      system("yarn run lint:scss") || abort
    end
  end
end
