class SearchesController < ApplicationController
  def show
    @search = if search_params
      Search.new(
        system: Current.system,
        query: search_params[:query],
        filter_tag_slugs: search_params[:tags]
      )
    else
      Search.new(system: Current.system)
    end

    if params.has_key?(:random) && random_entry.present?
      redirect_to random_entry
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
    end.compact_blank
  end

  def random_entry
    @random_entry ||= @search.random_entry
  end
end
