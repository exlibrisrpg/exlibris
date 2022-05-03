class ComponentPreviewsController < ViewComponentsController
  include SetCurrentRequestDetails

  def current_user
    # Any present user allows previewing from any subdomain
    true
  end
end
