class SystemDashboard < Avo::Dashboards::BaseDashboard
  self.id = "system"
  self.name = "System"
  self.description = "Stats and analytics for a given system"

  card VisitorsChart, cols: 3, rows: 1

  divider

  card PagesTable, cols: 1, rows: 4, label: "Top Pages"
  card PagesTable, cols: 1, rows: 4, label: "Top Entries", options: {page_filter: "/entries/**"}
  card PagesTable, cols: 1, rows: 4, label: "Top Tags", options: {page_filter: "/tags/**"}
end
