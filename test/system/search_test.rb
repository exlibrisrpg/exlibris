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

  test "infinite scroll search entries" do
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

  test "show random results" do
    visit search_path

    within "form" do
      fill_in Search.model_name.human, with: "hunting"
      click_on I18n.t("helpers.submit.search.random")
    end

    refute_selector "h1", text: I18n.t("searches.show.title")
    assert_text entries(:eat_prey_kill).name
  end

  test "use tag autocomplete with mouse" do
    visit search_path

    within "form" do
      fill_in Search.model_name.human, with: "joh"
      find("li", text: tags(:johan_nohr).name).click
      click_on I18n.t("helpers.submit.search.create")
    end

    assert_selector "input[type=\"hidden\"][name=\"tags[]\"][value=\"#{tags(:johan_nohr).slug}\"]", visible: false
  end

  test "use tag autocomplete with keyboard" do
    visit search_path

    within "form" do
      fill_in Search.model_name.human, with: "joh"
      find(:fillable_field, Search.model_name.human).send_keys(:down)
      find(:fillable_field, Search.model_name.human).send_keys(:enter)
      click_on I18n.t("helpers.submit.search.create")
    end

    assert_selector "input[type=\"hidden\"][name=\"tags[]\"][value=\"#{tags(:johan_nohr).slug}\"]", visible: false
  end

  test "remove existing filter tags" do
    visit search_path(tags: tags(:johan_nohr).slug)

    within "form" do
      find("[role=\"list\"]", text: tags(:johan_nohr).name).find("[data-action=\"click->combobox#remove\"]").click
    end

    refute_selector "input[type=\"hidden\"][name=\"tags[]\"][value=\"#{tags(:johan_nohr).slug}\"]", visible: false
  end
end
