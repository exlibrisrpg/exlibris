module IconHelper
  DEFAULT_ICON_OPTIONS = {
    class: "icon"
  }

  def icon_tag(icon_type, options = {})
    options = DEFAULT_ICON_OPTIONS.merge(options)
    path = "icon-#{icon_type.to_s.dasherize}.svg"
    inline_svg_tag(path, options)
  end
end
