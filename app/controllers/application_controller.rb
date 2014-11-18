class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authorize_profiler
  before_filter :maintenance

  def is_admin?
    user_signed_in? && current_user.is_admin?
  end

  private

  def authorize_profiler
    Rack::MiniProfiler.authorize_request if is_admin?
  end

  def maintenance
    render 'shared/maintenance', :status => 503 if Rails.configuration.maintenance && !is_admin?
  end
end
