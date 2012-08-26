module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Weather App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # def javascript(*args)
  #   content_for(:head) { javascript_include_tag(*args) }
  # end

end

