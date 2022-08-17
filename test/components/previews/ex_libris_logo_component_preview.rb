# @display body_class "tw-bg-gradient-to-tr tw-from-primary-9 tw-to-secondary-9"
# @display container false
# @display center true
class ExLibrisLogoComponentPreview < ViewComponent::Preview
  def default
    render(ExLibrisLogoComponent.new)
  end
end
