module ApplicationHelper
  def active_link(link)
    'active' if current_page?(link)
  end

  def flash_class(level)
    case level
    when :notice then "info"
    when :error then "danger"
    when :alert then "warning"
    end
  end
end
