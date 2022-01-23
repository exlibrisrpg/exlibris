require "test_helper"

class SystemPolicyTest < ActiveSupport::TestCase
  test "admin" do
    assert_permit users(:admin), :system, :index
    assert_permit users(:admin), System.new, :show
    assert_permit users(:admin), System.new, :create
    assert_permit users(:admin), System.new, :new
    assert_permit users(:admin), System.new, :update
    assert_permit users(:admin), System.new, :edit
    assert_permit users(:admin), System.new, :destroy

    assert_scope users(:admin), System.all, System.all
  end

  test "curator" do
    refute_permit users(:curator), :system, :index
    refute_permit users(:curator), System.new, :show
    refute_permit users(:curator), System.new, :create
    refute_permit users(:curator), System.new, :new
    refute_permit users(:curator), System.new, :update
    refute_permit users(:curator), System.new, :edit
    refute_permit users(:curator), System.new, :destroy

    assert_scope users(:curator), System.all, users(:curator).curated_systems
  end
end
