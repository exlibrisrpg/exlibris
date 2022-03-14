module SetCurrentRequestDetails
  extend ActiveSupport::Concern

  included do
    before_action do
      Current.system = requested_system
    end
  end

  private

  def requested_system
    if request.subdomain.present? && request.subdomain != "www"
      System.live.find_by!(slug: request.subdomain)
    else
      System.live.find_by!(name: "Mörk Borg")
    end
  end
end
