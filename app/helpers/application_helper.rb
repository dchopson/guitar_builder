module ApplicationHelper

  # @param page_title [String] the page title
  def title(page_title)
    content_for(:title) { page_title }
  end
end
