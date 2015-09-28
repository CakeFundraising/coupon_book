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
        redirect_to after_registration_update_path, notice: 'Welcome to Eats For Good!'
      end
    end
  end

  protected

  def after_registration_update_path
    if current_user.fundraiser?
      new_coupon_book_path
    elsif current_user.affiliate?
      new_affiliate_campaign_path
    elsif current_user.media_affiliate?
      new_media_affiliate_campaign_path
    else
      new_coupon_path
    end
  end

  def check_if_account_created
    redirect_to root_path, alert:"Please sign up to create a new account." if current_user.nil?
  end
end