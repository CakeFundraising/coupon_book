module AccountController
  extend ActiveSupport::Concern

  included do
    before_action :check_if_account_created, only: [:new, :create]
  end

  def new
    @user = current_user
    @user.build_location(country_code: 'US')
  end

  protected

  def check_if_account_created
    redirect_to root_path, alert:"Please sign out and create a new account if you want to create a new account." if current_user.nil?
  end
end