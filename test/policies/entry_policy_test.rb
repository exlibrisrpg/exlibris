require "test_helper"

class EntryPolicyTest < ActiveSupport::TestCase
  test "admin" do
    assert_permit users(:admin), :entry, :index
    assert_permit users(:admin), Entry.new, :show
    assert_permit users(:admin), Entry.new, :create
    assert_permit users(:admin), Entry.new, :new
    assert_permit users(:admin), Entry.new, :update
    assert_permit users(:admin), Entry.new, :edit
    assert_permit users(:admin), Entry.new, :destroy

    assert_scope users(:admin), Entry.all, Entry.all
  end

  test "curator" do
    assert_permit users(:curator), :entry, :index

    curated_entry = entries(:eat_prey_kill)
    assert_permit users(:curator), curated_entry, :show
    assert_permit users(:curator), curated_entry, :create
    assert_permit users(:curator), curated_entry, :new
    assert_permit users(:curator), curated_entry, :update
    assert_permit users(:curator), curated_entry, :edit
    assert_permit users(:curator), curated_entry, :destroy

    other_entry = entries(:honey_in_the_rafters)
    refute_permit users(:curator), other_entry, :show
    refute_permit users(:curator), other_entry, :create
    refute_permit users(:curator), other_entry, :new
    refute_permit users(:curator), other_entry, :update
    refute_permit users(:curator), other_entry, :edit
    refute_permit users(:curator), other_entry, :destroy

    assert_scope users(:curator), Entry.all, Entry.where(system: users(:curator).curated_systems)
  end
end
