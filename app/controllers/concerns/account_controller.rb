module AccountController
  extend ActiveSupport::Concern

  included do
    before_action :check_if_account_created, only: [:new, :create]
  end

  def new
    @user = current_user
  end

  protected

  def check_if_account_created
    role = current_user.roles.first unless current_user.nil?
    redirect_to root_path, alert:"Please sign out and create a new account if you want to create a new #{role.titleize} account." if current_user.nil? or role.present?
  end
end