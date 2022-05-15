class PagesTable < Avo::Dashboards::PartialCard
  include AnalyticsQueryable
  include SystemSwitchable

  self.id = "pages_table"
  self.label = "Pages"
  self.partial = "avo/cards/pages_table"

  def pages
    return [] unless authorized? && site_id

    response = Plausible::Client.new.breakdown(site_id, breakdown_params)
    response.body["results"]
  end

  def breakdown_params
    {}.tap do |params|
      params[:filters] = "event:page==#{options[:page_filter]}" if options[:page_filter].present?
    end
  end
end
