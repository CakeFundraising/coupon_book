module Referrer
  extend ActiveSupport::Concern

  protected

  def save_referrer
    session[:referrer_url] = request.fullpath
  end

  def destroy_referrer
    session.delete(:referrer_url)
  end
end