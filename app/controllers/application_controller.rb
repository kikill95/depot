class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def verifier
    @verifier ||= ActiveSupport::MessageVerifier.new(SECRETS.secret_key_base, url_safe: true)
  end

  def require_guest
    return unless current_user
    flash[:warning] = 'Ooooops'
    redirect_to admin_products_path
  end

  def require_user
    return if current_user
    flash[:warning] = 'Ooooops'
    redirect_to root_path
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.secrets.admin_user && password == Rails.application.secrets.admin_password
    end
  end
end
