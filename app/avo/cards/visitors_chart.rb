class VisitorsChart < Avo::Dashboards::ChartkickCard
  self.id = "visitors_chart"
  self.label = "Visitors"
  self.chart_type = :area_chart

  def query
    response = Plausible::Client.new.timeseries(site_id)
    data = response.body["results"].map { |datum| [datum["date"], datum["visitors"]] }.to_h
    result [{name: "Visitors", data: data}]
  end

  def site_id
    "exlibrisrpg.com"
  end
end
