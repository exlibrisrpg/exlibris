require "test_helper"

class CurationRoleTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user)
    should belong_to(:system)
  end
end
