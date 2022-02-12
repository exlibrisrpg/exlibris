class TagCategoryPolicy < ApplicationPolicy
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
    user.admin? || tag_category_curated_by_user?
  end

  def new?
    user.admin? || user.curator?
  end

  def create?
    user.admin? || tag_category_curated_by_user?
  end

  def update?
    user.admin? || tag_category_curated_by_user?
  end

  def destroy?
    user.admin? || tag_category_curated_by_user?
  end

  private

  def tag_category_curated_by_user?
    # Permit blank systems - these will be enforced by validations
    return true if record.system.blank?

    user.curated_systems.include? record.system
  end
end
