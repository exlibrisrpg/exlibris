class SystemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user.admin?

      scope.merge(user.curated_systems)
    end
  end

  def show?
    super || entry_curated_by_user?
  end

  private

  def entry_curated_by_user?
    # Can't perform this check if Avo provides a class
    return true if record.is_a? Class

    # Permit blank systems - these will be enforced by validations
    return true if record.blank?

    user.curated_systems.include? record
  end
end
