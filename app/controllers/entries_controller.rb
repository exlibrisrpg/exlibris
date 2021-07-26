class EntriesController < ApplicationController
  def index
    set_page_and_extract_portion_from Entry.all.with_includes
  end

  def show
    @entry = Entry.with_includes.find(params[:id])
  end
end
