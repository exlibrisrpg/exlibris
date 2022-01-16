require "test_helper"

class SystemPolicyTest < ActiveSupport::TestCase
  test "admin" do
    assert_permit users(:admin), :user, :index
    assert_permit users(:admin), User.new, :show
    assert_permit users(:admin), User.new, :create
    assert_permit users(:admin), User.new, :new
    assert_permit users(:admin), User.new, :update
    assert_permit users(:admin), User.new, :edit
    assert_permit users(:admin), User.new, :destroy

    assert_scope users(:admin), User.all, User.all
  end

  test "curator" do
    refute_permit users(:curator), :user, :index
    refute_permit users(:curator), User.new, :show
    refute_permit users(:curator), User.new, :create
    refute_permit users(:curator), User.new, :new
    refute_permit users(:curator), User.new, :update
    refute_permit users(:curator), User.new, :edit
    refute_permit users(:curator), User.new, :destroy

    assert_scope users(:curator), User.all, User.none
  end

  test "anonymous" do
    refute_permit nil, :user, :index
    refute_permit nil, User.new, :show
    refute_permit nil, User.new, :create
    refute_permit nil, User.new, :new
    refute_permit nil, User.new, :update
    refute_permit nil, User.new, :edit
    refute_permit nil, User.new, :destroy

    assert_scope nil, User.all, User.none
  end
end
