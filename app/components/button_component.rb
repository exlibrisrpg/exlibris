class ButtonComponent < ViewComponent::Base
  attr_reader :label, :path

  def initialize(label:, path: nil, type: :primary)
    @label = label
    @path = path
    @type = type
  end

  def css_class
    css_class = ["tw-button"]
    css_class << case @type
    when :secondary
      "tw-button-secondary"
    when :accent
      "tw-button-accent"
    else
      Rails.logger.warn "Unknown class for ButtonComponent type: #{@type}"
    end

    css_class.join(" ")
  end
end
