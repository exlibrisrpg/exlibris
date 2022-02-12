class NilSystem
  delegate :entries, :tag_categories, to: :default_system

  private

  def default_system
    @_default_system ||= System.find_by(name: "Mörk Borg")
  end
end
