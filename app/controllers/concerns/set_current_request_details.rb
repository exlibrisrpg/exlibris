module SetCurrentRequestDetails
  extend ActiveSupport::Concern

  included do
    before_action :set_current_request_details
  end

  private

  def set_current_request_details
    Current.system = requested_system
    request.variant = Current.system.slug.to_sym
  end

  def requested_system
    scope = current_user.present? ? System.all : System.live

    if request.subdomain.present? && request.subdomain != "www"
      scope.find_by!(slug: request.subdomain)
    else
      scope.find_by!(name: "Mörk Borg")
    end
  end
end
