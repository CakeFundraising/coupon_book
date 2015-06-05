class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_fundraiser, :current_sponsor

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def current_user
    @current_user ||= User.find_by_access_token(session[:access_token])
  end

  def current_fundraiser
    current_user.fundraiser if current_user.present? and current_user.fundraiser?
  end

  def current_sponsor
    current_user.sponsor if current_user.present? and current_user.sponsor?
  end
end
