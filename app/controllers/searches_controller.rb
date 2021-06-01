class SearchesController < ApplicationController
  def show
    @search = if search_params
      Search.new(search_params)
    else
      Search.new
    end
    set_page_and_extract_portion_from @search.entries
  end

  private

  def search_params
    params.permit(:query)
  end
end
