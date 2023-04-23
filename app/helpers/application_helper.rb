module ApplicationHelper
  def full_title(title = '')
    default_title = "RailsApp"
    title.blank? ? default_title : "#{title} | #{default_title}"
  end
end
