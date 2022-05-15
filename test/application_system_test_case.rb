require "capybara/cuprite"
require "test_helper"
require "test_helpers/clearance"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, screen_size: [1400, 1400]

  include ClearanceHelpers::SystemTestHelpers

  setup do
    Capybara.app_host = "http://testlibrisrpg.test"
  end
end
