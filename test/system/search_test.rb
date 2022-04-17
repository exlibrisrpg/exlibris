require "application_system_test_case"

class SearchTest < ApplicationSystemTestCase
  test "show entries results" do
    entry = current_system.entries.last

    visit search_path

    within "form" do
      fill_in Search.model_name.human, with: entry.name
      click_on I18n.t("helpers.submit.search.create")
    end

    assert_text entry.name, normalize_ws: true
  end

  test "infinite scroll search entries" do
    Entry.create(
      20.times.map do |i|
        {
          name: "Example Entry #{i}",
          description: "Placeholder description",
          system: current_system
        }
      end
    )

    visit search_path(query: "placeholder")

    refute_selector "turbo-frame[busy]"

    assert_scrolling_loads_more_entries
  end

  test "show random results" do
    entry = current_system.entries.last

    visit search_path

    within "form" do
      fill_in Search.model_name.human, with: entry.name
      click_on I18n.t("helpers.submit.search.random")
    end

    refute_selector "h1", text: I18n.t("searches.show.title")
    assert_text entry.name
  end

  test "use tag autocomplete with mouse" do
    tag = current_system.tags.last

    visit search_path

    within "form" do
      fill_in Search.model_name.human, with: tag.name[0..3]
      find("li", text: tag.name).click
      click_on I18n.t("helpers.submit.search.create")
    end

    assert_selector "input[type=\"hidden\"][name=\"tags[]\"][value=\"#{tag.slug}\"]", visible: false
  end

  test "use tag autocomplete with keyboard" do
    tag = current_system.tags.last

    visit search_path

    within "form" do
      fill_in Search.model_name.human, with: tag.name[0..3]
      find(:fillable_field, Search.model_name.human).send_keys(:down)
      find(:fillable_field, Search.model_name.human).send_keys(:enter)
      click_on I18n.t("helpers.submit.search.create")
    end

    assert_selector "input[type=\"hidden\"][name=\"tags[]\"][value=\"#{tag.slug}\"]", visible: false
  end

  test "remove existing filter tags" do
    visit search_path(tags: tags(:johan_nohr).slug)

    within "form" do
      find("[role=\"list\"]", text: tags(:johan_nohr).name).find("[data-action=\"click->combobox#remove\"]").click
    end

    refute_selector "input[type=\"hidden\"][name=\"tags[]\"][value=\"#{tags(:johan_nohr).slug}\"]", visible: false
  end
end
