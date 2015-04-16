class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_fundraiser, :current_sponsor

  def current_user
    #session[:access_token] = nil
    @current_user ||= User.find_by_access_token(session[:access_token])
  end

  def current_fundraiser
    current_user.fundraiser if current_user.fundraiser?
  end

  def current_sponsor
    current_user.sponsor if current_user.sponsor?
  end
end
