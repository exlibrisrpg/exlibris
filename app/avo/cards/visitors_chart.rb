class VisitorsChart < Avo::Dashboards::ChartkickCard
  include AnalyticsQueryable
  include SystemSwitchable

  self.id = "visitors_chart"
  self.label = "Visitors"
  self.chart_type = :area_chart

  def query
    return [] unless authorized? && site_id

    response = Plausible::Client.new.timeseries(site_id)
    data = response.body["results"].map { |datum| [datum["date"], datum["visitors"]] }.to_h
    result [{name: "Visitors", data: data}]
  end
end
