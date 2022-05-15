module AnalyticsQueryable
  extend ActiveSupport::Concern

  def site_id
    return "#{system.slug}.exlibrisrpg.com" if system.present?

    "exlibrisrpg.com" if user.admin?
  end
end
