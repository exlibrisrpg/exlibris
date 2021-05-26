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
    name = link_name(link)
    icon = case name
           when "drivethrurpg.com"
             "dtrpg.png"
           when "dropbox.com"
             "dropbox.png"
           when "facebook.com"
             "facebook.png"
           when "google.com"
             "google.png"
           when "itch.io"
             "itch.png"
           when "morkborg.com"
             "morkborg.png"
           else
             "link.png"
    end
    LINK_ICON_PREFIX + icon
  end
end
