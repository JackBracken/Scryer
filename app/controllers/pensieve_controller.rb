class PensieveController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  def bookmark
    if is_page_load?
      ChapterLoadEvent.from_params(current_user, request, params).save!
    else
      ChapterExitEvent.from_params(current_user, request, params).save!
    end

    render_200
  end

  private

  def render_200
    head 200, content_type: 'application/json'
  end

  def is_page_load?
    params['event_name'] == 'chapter_load'
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == 'OPTIONS'
      cors_set_access_control_headers
      headers['Access-Control-Allow-Headers'] = request.headers['Access-Control-Request-Headers'] || ''

      render_200
    end
  end

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end
end
