module MetaTags
  class MetaTagsCollection
    def extract_full_title
      site_title = extract(:site) || ""
      title = extract_title || []
      separator = extract_separator
      reverse = extract(:reverse) == true
      if Array.new(title) == [site_title]
        site_title = ""
      end

      TextNormalizer.normalize_title(site_title, title, separator, reverse)
    end
  end
end
