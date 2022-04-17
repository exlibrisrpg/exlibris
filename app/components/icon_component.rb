class IconComponent < ViewComponent::Base
  attr_reader :type

  def initialize(type:)
    @type = type
  end

  def call
    helpers.inline_svg_tag path, class: "tw-flex-shrink-0"
  end

  def path
    "icon-#{type.to_s.dasherize}.svg"
  end
end
