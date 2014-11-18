class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authorize
  before_filter :maintenance

  def authorize
    if is_admin?
      Rack::MiniProfiler.authorize_request
    end
  end

  def is_admin?
    user_signed_in? && current_user.is_admin?
  end

  def maintenance
    if Rails.configuration.maintenance && !is_admin?
      render 'shared/maintenance', :status => 503
    end
  end
end
