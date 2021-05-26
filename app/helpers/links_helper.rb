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

  def link_icon(link)
    name = link_name(link)
    case name
    when "dropbox.com"
      :dropbox
    when "facebook.com"
      :facebook
    when "google.com"
      :google
    when "itch.io"
      :itch
    when "morkborg.com"
      :morkborg
    else
      :link
    end
  end
end
