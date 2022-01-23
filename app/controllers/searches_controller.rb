class SearchesController < ApplicationController
  def show
    @search = if search_params
      Search.new(
        query: search_params[:query],
        filter_tag_slugs: search_params[:tags]
      )
    else
      Search.new
    end

    if params.has_key?(:random) && search_params.present?
      redirect_to @search.random_entry
    else
      set_page_and_extract_portion_from @search.entries
    end
  end

  private

  def search_params
    params.permit(:query, tags: []).tap do |permitted|
      if params[:tags].present?
        permitted[:tags] = params[:tags].split(",") if permitted[:tags].blank?
      end
    end
  end
end
