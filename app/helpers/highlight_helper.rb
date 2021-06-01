module HighlightHelper
  HIGHLIGHT_LINK_DEFAULT_OPTIONS = {
    data: {
      controller: "highlight"
    }
  }

  def highlight_link_to(name = nil, options = nil, html_options = {}, &block)
    if block
      merged_html_options = HIGHLIGHT_LINK_DEFAULT_OPTIONS.deep_merge(options)
      link_to name, merged_html_options, &block
    else
      merged_html_options = HIGHLIGHT_LINK_DEFAULT_OPTIONS.deep_merge(html_options)
      link_to name, options, merged_html_options
    end
  end
end
