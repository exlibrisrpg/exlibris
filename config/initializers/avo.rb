Avo.configure do |config|
  ## == Routing ==
  config.root_path = "/admin"

  ## == Licensing ==
  if Rails.application.credentials.dig(:avo, :license_key).present?
    config.license = "pro"
    config.license_key = Rails.application.credentials.dig(:avo, :license_key)
  else
    config.license = "community"
  end

  ## == Set the context ==
  config.set_context do
    {
      user: _current_user
    }
  end

  ## == Authentication ==
  config.current_user_method do
    request.env[:clearance].current_user
  end
  config.authenticate_with do
    unless request.env[:clearance].signed_in?
      respond_to do |format|
        format.any(:js, :json, :xml) { head :unauthorized }
        format.any do
          if request.get?
            session[:return_to] = request.original_fullpath
          end

          redirect_to main_app.sign_in_path
        end
      end
    end
  end

  ## == Authorization ==
  # config.authorization_methods = {
  #   index: 'index?',
  #   show: 'show?',
  #   edit: 'edit?',
  #   new: 'new?',
  #   update: 'update?',
  #   create: 'create?',
  #   destroy: 'destroy?',
  # }

  ## == Localization ==
  # config.locale = 'en-US'

  ## == Customization ==
  config.app_name = "Ex Libris Mörk Borg"
  # config.timezone = 'UTC'
  # config.currency = 'USD'
  # config.per_page = 24
  # config.per_page_steps = [12, 24, 48, 72]
  # config.via_per_page = 8
  # config.default_view_type = :table
  # config.id_links_to_resource = false
  # config.full_width_container = false
  config.full_width_index_view = true
  # config.cache_resources_on_index_view = true
  # config.search_debounce = 300

  # Where should the user be redirected when he hits the `/avo` url
  config.home_path = "/admin/dashboard"

  ## == Breadcrumbs ==
  config.display_breadcrumbs = true
  config.set_initial_breadcrumbs do
    add_breadcrumb "Admin", "/admin/dashboard"
  end
end
