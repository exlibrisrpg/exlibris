class SearchesController < ApplicationController
  def show
    @search = if search_params
      Search.new(search_params)
    else
      Search.new
    end

    if params.has_key?(:random)
      redirect_to @search.random_entry
    else
      set_page_and_extract_portion_from @search.entries
    end
  end

  private

  def search_params
    params.permit(:query)
  end
end
