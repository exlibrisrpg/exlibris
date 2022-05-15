module SystemSwitchable
  extend ActiveSupport::Concern

  def system
    systems_scope.find_by(slug: params[:system]) ||
      (systems_scope.first if systems_scope.one?)
  end

  def authorized?
    SystemPolicy.new(user, system).show?
  end

  def systems_scope
    SystemPolicy::Scope.new(user, System.order(:name)).resolve
  end

  def user
    context[:user]
  end
end
