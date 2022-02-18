module EntriesHelpers
  def entries_in_page
    find_all(:xpath, "//*[starts-with(@id, 'entry_')]", visible: false)
  end

  def assert_scrolling_loads_more_entries
    assert_changes -> { entries_in_page.count } do
      # Scroll to the bottom of the first frame which should trigger the load
      # behaviour
      page.scroll_to(find("turbo-frame#page_1"), align: :bottom)

      # Make sure that the frame starts loading
      find("turbo-frame#page_2[busy]")

      # Make sure that the frame has finished loading before counting entries
      # again
      find("turbo-frame#page_2[disabled]")
    end
  end
end
