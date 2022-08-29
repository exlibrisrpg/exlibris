class UserRoleFilter < Avo::Filters::BooleanFilter
  self.name = "Role"

  def apply(request, query, values)
    return query if values["is_admin"] && values["is_curator"]
    if values["is_admin"]
      query = query.admin
    elsif values["is_curator"]
      query = query.curator
    end
    query
  end

  def options
    {
      is_admin: "Admin",
      is_curator: "Curator"
    }
  end
end
