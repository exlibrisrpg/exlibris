ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "test_helpers/shoulda"
require "test_helpers/clearance"
require "test_helpers/entries"
require "test_helpers/pundit"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include ClearanceHelpers::ControllerTestHelpers
  include EntriesHelpers
  include PunditHelpers::PolicyTestHelpers
end
