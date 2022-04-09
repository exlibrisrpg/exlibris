require "test_helper"

class TagPolicyTest < ActiveSupport::TestCase
  test "admin" do
    assert_permit users(:admin), Tag, :index
    assert_permit users(:admin), Tag.new, :show
    assert_permit users(:admin), Tag.new, :create
    assert_permit users(:admin), Tag, :new
    assert_permit users(:admin), Tag.new, :update
    assert_permit users(:admin), Tag.new, :edit
    assert_permit users(:admin), Tag.new, :destroy

    assert_scope users(:admin), Tag.all, Tag.all
  end

  test "curator" do
    assert_permit users(:curator), Tag, :index
    assert_permit users(:curator), Tag, :new

    curated_tag = tags(:mork_borg_rules)
    assert_permit users(:curator), curated_tag, :show
    assert_permit users(:curator), curated_tag, :create
    assert_permit users(:curator), curated_tag, :update
    assert_permit users(:curator), curated_tag, :edit
    assert_permit users(:curator), curated_tag, :destroy
    assert_permit users(:curator), curated_tag, :upload_attachments
    assert_permit users(:curator), curated_tag, :download_attachments
    assert_permit users(:curator), curated_tag, :delete_attachments

    other_tag = tags(:mausritter_rules)
    refute_permit users(:curator), other_tag, :show
    refute_permit users(:curator), other_tag, :create
    refute_permit users(:curator), other_tag, :update
    refute_permit users(:curator), other_tag, :edit
    refute_permit users(:curator), other_tag, :destroy
    refute_permit users(:curator), other_tag, :upload_attachments
    refute_permit users(:curator), other_tag, :download_attachments
    refute_permit users(:curator), other_tag, :delete_attachments

    assert_scope users(:curator), Tag.all, Tag.where(system: users(:curator).curated_systems)
  end
end
