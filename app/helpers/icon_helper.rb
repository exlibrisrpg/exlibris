module IconHelper
  DEFAULT_ICON_OPTIONS = {
    class: "tw-flex-shrink-0 tw-w-5 tw-h-5"
  }

  def icon_tag(icon_type, options = {})
    options = DEFAULT_ICON_OPTIONS.merge(options)
    path = "icon-#{icon_type.to_s.dasherize}.svg"
    inline_svg_tag(path, options)
  end
end
