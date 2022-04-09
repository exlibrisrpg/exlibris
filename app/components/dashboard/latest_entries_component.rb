class Dashboard::LatestEntriesComponent < ViewComponent::Base
  attr_reader :entries

  def initialize(entries:)
    @entries = entries
  end
end
