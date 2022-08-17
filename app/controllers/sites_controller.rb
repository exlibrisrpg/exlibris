class SitesController < ApplicationController
  layout "site"

  def show
    @systems = System.all.order(:name)
  end
end
