class PaginationComponent < ViewComponent::Base
  include Turbo::FramesHelper

  Page = Struct.new(:number, :id, :path)

  renders_one :body

  def initialize(page:, path:)
    @page = page
    @path = path
  end

  def current_page
    id = @page.number
    Page.new(id, "page_#{@page.number}")
  end

  def next_page
    if !@page.last?
      id = @page.number + 1
      Page.new(id, "page_#{id}", @path.call(id))
    end
  end

  def previous_page
    if !@page.first?
      id = @page.number - 1
      Page.new(id, "page_#{id}", @path.call(id))
    end
  end

  def total_pages
    @page.recordset.page_count
  end
end
