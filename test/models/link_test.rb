require "test_helper"

class LinkTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to :entry
  end

  context "validations" do
    should validate_presence_of(:address)
  end
end
