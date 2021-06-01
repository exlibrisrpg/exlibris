require "test_helper"
require "minitest/mock"

class IconHelperTest < ActionView::TestCase
  context "#icon_tag" do
    setup do
      def self.inline_svg_tag
      end
    end

    should "call inline_svg_pack_tag with the correct path" do
      svg_tag = "<svg></svg"
      expected_path = "icon-name.svg"
      expected_options = {class: "icon"}

      stub :inline_svg_tag, ->(path, options) { svg_tag if path == expected_path && options == expected_options } do
        assert_equal icon_tag(:name), svg_tag
      end
    end

    should "call inline_svg_pack_tag with the correctly formatted path" do
      svg_tag = "<svg></svg"
      expected_path = "icon-longer-name.svg"
      expected_options = {class: "icon"}

      stub :inline_svg_tag, ->(path, options) { svg_tag if path == expected_path && options == expected_options } do
        assert_equal icon_tag(:longer_name), svg_tag
      end
    end

    should "call inline_svg_pack_tag with additional options merged" do
      svg_tag = "<svg></svg"
      expected_path = "icon-name.svg"
      expected_options = {class: "icon", extra: :option}

      stub :inline_svg_tag, ->(path, options) { svg_tag if path == expected_path && options == expected_options } do
        assert_equal svg_tag, icon_tag(:name, extra: :option)
      end
    end

    should "call inline_svg_pack_tag with default options overwritten" do
      svg_tag = "<svg></svg"
      expected_path = "icon-name.svg"
      expected_options = {class: "icon--large"}

      stub :inline_svg_tag, ->(path, options) { svg_tag if path == expected_path && options == expected_options } do
        assert_equal icon_tag(:name, class: "icon--large"), svg_tag
      end
    end
  end
end
