require "capybara/cuprite"
require "test_helper"
require "test_helpers/clearance"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, screen_size: [1400, 1400]

  include ClearanceHelpers::SystemTestHelpers

  def current_system
    systems(ENV["RAILS_SYSTEM_TEST_SUBDOMAIN"].to_sym)
  end
end
