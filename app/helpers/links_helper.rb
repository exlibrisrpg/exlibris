module LinksHelper
  LINK_EXPRESSIONS = [
    /(?<name>itch\.io)/,
    /^(?:https?:\/\/)?(?:www\.)?(?<name>[\w\d.]+)\/?/
  ]

  def link_name(link)
    match = LINK_EXPRESSIONS.detect do |expression|
      link.address =~ expression
    end

    return link.address unless match

    match.match(link.address)["name"]
  end

  LINK_ICON_PREFIX = "/images/linkicons/"

  def link_icon(link)
    case link_name(link)
    when "drivethrurpg.com"
      icon = "dtrpg.png"
    when "dropbox.com"
      icon = "dropbox.png"
    when "facebook.com"
      icon = "facebook.png"
    when "google.com"
      icon = "google.png"
    when "itch.io"
      icon = "itch.png"
    when "morkborg.com"
      icon = "morkborg.png"
    else
      icon = "link.png"
    end
    LINK_ICON_PREFIX + icon
  end
end
