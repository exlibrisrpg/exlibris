require "test_helper"

class SystemTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:curation_roles).dependent(:destroy)
    should have_many(:curators)
    should have_many(:entries)
    should have_many(:tags)
    should have_many(:tag_categories)
  end

  context "validations" do
    should validate_presence_of(:name)
  end

  context "after_create" do
    should "populate a slug" do
      system = System.create(name: "John's cynical OSR cash-in")
      assert_equal "john-s-cynical-osr-cash-in", system.slug
    end
  end

  context ".live" do
    should "scope to live systems" do
      assert_equal System.all.where(live: true), System.live
    end
  end
end
