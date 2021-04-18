module IconHelper
  DEFAULT_ICON_OPTIONS = {
    class: "icon"
  }

  def icon_tag(icon_type, options = {})
    options = DEFAULT_ICON_OPTIONS.merge(options)
    path = "media/svg/icon-#{icon_type.to_s.dasherize}.svg"
    inline_svg_pack_tag(path, options)
  end
end
