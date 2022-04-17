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

    scope.find_by!(slug: current_subdomain)
  end

  def current_subdomain
    if Rails.env.test? && ENV["RAILS_SYSTEM_TEST_SUBDOMAIN"].present?
      ENV["RAILS_SYSTEM_TEST_SUBDOMAIN"]
    elsif request.subdomain.present? && request.subdomain != "www"
      request.subdomain
    else
      "morkborg"
    end
  end
end
