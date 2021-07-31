require "application_system_test_case"

class SearchTest < ApplicationSystemTestCase
  test "show entries results" do
    visit search_path

    within "form" do
      fill_in Search.model_name.human, with: "hunting"
      click_on I18n.t("helpers.submit.search.create")
    end

    assert_text entries(:eat_prey_kill).name
  end

  test "show tags results" do
    visit search_path

    within "form" do
      fill_in Search.model_name.human, with: "cult"
      click_on I18n.t("helpers.submit.search.create")
    end

    assert_link tags(:mork_borg_cult).name
  end

  test "infinite scroll tag entries" do
    Entry.create(
      20.times.map do |i|
        {
          name: "Example Entry #{i}",
          description: "Placeholder description"
        }
      end
    )

    visit search_path(query: "placeholder")

    assert_scrolling_loads_more_entries
  end
end
