class AnalyticsComponent < ViewComponent::Base
  def call
    javascript_include_tag "https://plausible.io/js/plausible.js", defer: true, data: {domain: domains}
  end

  def domains
    ["#{Current.system.slug}.exlibrisrpg.com", "exlibrisrpg.com"].join(",")
  end

  def render?
    ENV["COLLECT_ANALYTICS"].present?
  end
end
