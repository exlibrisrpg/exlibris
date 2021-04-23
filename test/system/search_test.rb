require "application_system_test_case"

class SearchTest < ApplicationSystemTestCase
  test "show entries results" do
    visit search_path

    fill_in Search.model_name.human, with: "hunting"
    click_on I18n.t("helpers.submit.search.create")

    assert_text entries(:eat_prey_kill).name
  end

  test "show tags results" do
    visit search_path

    fill_in Search.model_name.human, with: "cult"
    click_on I18n.t("helpers.submit.search.create")

    assert_link tags(:mork_borg_cult).name
  end
end
