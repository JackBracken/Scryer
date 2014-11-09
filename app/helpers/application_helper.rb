module ApplicationHelper
  def active_link(link)
    'active' if current_page?(link)
  end
end
