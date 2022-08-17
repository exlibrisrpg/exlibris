# @display body_class "tw-bg-gradient-to-tr tw-from-primary-9 tw-to-secondary-9"
class SystemTokenComponentPreview < ViewComponent::Preview
  # @param name
  # @param count
  # @param url
  def live(name: "Mörk Borg", count: 765, url: "morkborg.exlibrisrpg.test")
    render(SystemTokenComponent.new(name: name, count: count, live: true, url: url))
  end

  # @param name
  # @param count
  def not_live(name: "Mörk Borg", count: 765)
    render(SystemTokenComponent.new(name: name, count: count, live: false))
  end

  def collection
  end
end
