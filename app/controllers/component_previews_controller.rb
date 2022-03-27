class ComponentPreviewsController < ViewComponentsController
  include SetCurrentRequestDetails

  # Copied from lookbook so we can set appropriate variant
  # https://github.com/allmarkedup/lookbook/blob/v0.6.1/lib/lookbook/preview_controller.rb#L17-L20
  def render_in_layout_to_string(template, locals, layout = nil)
    set_current_request_details

    super(template, locals, layout)
  end

  def render_example_to_string(preview, example_name)
    set_current_request_details

    super(preview, example_name)
  end

  def current_user
    # Any present user allows previewing from any subdomain
    true
  end
end
