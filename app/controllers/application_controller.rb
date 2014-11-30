class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authorize_profiler
  before_filter :maintenance

  before_action :configure_permitted_parameters, if: :devise_controller?

  def admin?
    user_signed_in? && current_user.admin?
  end

  protected


  def authorize_profiler
    Rack::MiniProfiler.authorize_request if admin?
  end

  def maintenance
    render 'shared/maintenance', :status => 503 if Rails.configuration.maintenance && !admin?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
end
