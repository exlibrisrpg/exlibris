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
end
