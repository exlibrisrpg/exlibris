class SystemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.all if user.admin?

      scope.merge(user.curated_systems)
    end
  end
end
