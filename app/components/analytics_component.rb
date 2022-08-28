class AnalyticsComponent < ViewComponent::Base
  def call
    javascript_include_tag "https://plausible.io/js/plausible.js", defer: true, data: {domain: domains}
  end

  def domains
    domains = ["exlibrisrpg.com"]
    domains << "#{Current.system.slug}.exlibrisrpg.com" if Current.system.present?
    domains.join(",")
  end

  def render?
    ENV["COLLECT_ANALYTICS"].present?
  end
end
