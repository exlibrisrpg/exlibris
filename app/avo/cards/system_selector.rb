class SystemSelector < Avo::Dashboards::PartialCard
  include SystemSwitchable

  self.id = "system_selector"
  self.label = "Select system"
  self.partial = "avo/cards/system_selector"
  self.display_header = false
  self.cols = 3
  self.rows = 0

  def system_slug
    params[:system]
  end

  def available_systems
    options = systems_scope.pluck(:name, :slug)
    options.prepend(["All systems", ""]) if user.admin?
    options
  end
end
