class SessionsController < Devise::SessionsController
  before_action :store_redirect_url, only: :new

  protected

  def store_redirect_url
    session[:redirect_to] = params[:redirect_to] if params[:redirect_to].present?
  end
end