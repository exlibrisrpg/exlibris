require "test_helper"

class TagCategoryPolicyTest < ActiveSupport::TestCase
  test "admin" do
    assert_permit users(:admin), TagCategory, :index
    assert_permit users(:admin), TagCategory.new, :show
    assert_permit users(:admin), TagCategory.new, :create
    assert_permit users(:admin), TagCategory, :new
    assert_permit users(:admin), TagCategory.new, :update
    assert_permit users(:admin), TagCategory.new, :edit
    assert_permit users(:admin), TagCategory.new, :destroy

    assert_scope users(:admin), TagCategory.all, TagCategory.all
  end

  test "curator" do
    assert_permit users(:curator), TagCategory, :index
    assert_permit users(:curator), TagCategory, :new

    curated_tag = tag_categories(:categories_mork_borg)
    assert_permit users(:curator), curated_tag, :show
    assert_permit users(:curator), curated_tag, :create
    assert_permit users(:curator), curated_tag, :update
    assert_permit users(:curator), curated_tag, :edit
    assert_permit users(:curator), curated_tag, :destroy
    assert_permit users(:curator), curated_tag, :upload_attachments
    assert_permit users(:curator), curated_tag, :download_attachments
    assert_permit users(:curator), curated_tag, :delete_attachments

    other_tag = tag_categories(:categories_mausritter)
    refute_permit users(:curator), other_tag, :show
    refute_permit users(:curator), other_tag, :create
    refute_permit users(:curator), other_tag, :update
    refute_permit users(:curator), other_tag, :edit
    refute_permit users(:curator), other_tag, :destroy
    refute_permit users(:curator), other_tag, :upload_attachments
    refute_permit users(:curator), other_tag, :download_attachments
    refute_permit users(:curator), other_tag, :delete_attachments

    assert_scope users(:curator), TagCategory.all, TagCategory.where(system: users(:curator).curated_systems)
  end
end
