module AccountController
  extend ActiveSupport::Concern

  included do
    before_action :check_if_account_created, only: [:new, :create]
  end

  def new
    @user = current_user
    @user.build_location(country_code: 'US')
  end

  def update
    update! do |success, failure|
      success.html do
        #send_notification
        redirect_to dashboard_account_path, notice: 'Profile updated.'
      end
    end
  end

  def registration_update
    update! do |success, failure|
      success.html do
        #send_notification
        resource.registered!
        redirect_to dashboard_dashboard_path, notice: 'Now start your first Eats for Good Campaign!'
      end
    end
  end

  protected

  def check_if_account_created
    redirect_to root_path, alert:"Please sign out and create a new account if you want to create a new account." if current_user.nil?
  end
end