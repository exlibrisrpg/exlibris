class EntryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user.admin?

      scope.where(system: user.curated_systems)
    end
  end

  def index?
    user.admin? || user.curator?
  end

  def show?
    user.admin? || entry_curated_by_user?
  end

  def new?
    user.admin? || user.curator?
  end

  def create?
    user.admin? || entry_curated_by_user?
  end

  def update?
    user.admin? || entry_curated_by_user?
  end

  def destroy?
    user.admin? || entry_curated_by_user?
  end

  def order?
    user.admin? || entry_curated_by_user?
  end

  private

  def entry_curated_by_user?
    # Can't perform this check if Avo provides a class
    return true if record.is_a? Class

    # Permit blank systems - these will be enforced by validations
    return true if record.system.blank?

    user.curated_systems.include? record.system
  end
end
