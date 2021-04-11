require "test_helper"

class TagTest < ActiveSupport::TestCase
  context "validations" do
    should validate_presence_of :name
  end
end
