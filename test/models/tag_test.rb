require "test_helper"

class TagTest < ActiveSupport::TestCase
  context "associations" do
    should have_and_belong_to_many :entries
  end

  context "validations" do
    should validate_presence_of :name
  end
end
