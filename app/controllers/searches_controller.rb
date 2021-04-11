class SearchesController < ApplicationController
  def show
    @search = if search_params
      Search.new(search_params)
    else
      Search.new
    end
  end

  private

  def search_params
    params.permit(:query)
  end
end
