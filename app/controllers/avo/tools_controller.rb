class Avo::ToolsController < Avo::ApplicationController
  def dashboard
    @page_title = "Admin"
    @analytics_embed_url = Rails.application.credentials.dig(:analytics, :embed_url)
  end
end
