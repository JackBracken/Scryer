module ApplicationHelper
  def favicon_name
    if Rails.env.development?
      'favicon_development.ico'
    else
      'favicon.ico'
    end
  end

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
