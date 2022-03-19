class DashboardsController < ApplicationController
  def show
    @dashboard = Dashboard.new(system: Current.system)
  end
end
