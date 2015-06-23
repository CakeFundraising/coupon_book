class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cake_access_token
  helper_method :current_user, :current_fundraiser, :current_sponsor, :current_browser

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def current_user
    @current_user ||= User.find_by_access_token(session[:access_token])
  end

  def current_fundraiser
    @current_fundraiser ||= current_user.fundraiser if current_user.present? and current_user.fundraiser?
  end

  def current_sponsor
    @current_sponsor ||= current_user.sponsor if current_user.present? and current_user.sponsor?
  end

  def current_browser
    token = evercookie_get_value(:cfbid)
    @current_browser ||= Browser.find_by_token(token) if token.present?
  end

  private

  def set_evercookie(key, value)
    session[:evercookie] = {} unless session[:evercookie].present?
    session[:evercookie][key] = value
  end

  def evercookie_get_value(key)
    session[:evercookie].present? ? session[:evercookie][key] : nil
  end

  def evercookie_is_set?(key, value = nil)
    if session[:evercookie].blank?
      false
    elsif value.nil?
      session[:evercookie][key].present?
    else
      session[:evercookie][key].present? and session[:evercookie][key] == value
    end
  end

  def set_cake_access_token
    session[:access_token] = params[:cat] if params[:cat].present?
  end
end
