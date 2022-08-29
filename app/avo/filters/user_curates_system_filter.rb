class UserCuratesSystemFilter < Avo::Filters::SelectFilter
  self.name = "Curates system"

  def apply(request, query, value)
    return query unless value.present?

    query.includes(:curation_roles).where(curation_roles: {system: value}).or(query.admin)
  end

  def options
    System
      .select(:id, :name)
      .each_with_object({}) { |system, options| options[system.id] = system.name }
  end
end
