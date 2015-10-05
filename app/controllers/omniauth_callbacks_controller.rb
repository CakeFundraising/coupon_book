class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Referrer

  after_action :destroy_referrer, only: :stripe_connect

  def facebook
    callback_of("Facebook")
  end

  def twitter
    callback_of("Twitter")
  end

  def stripe_connect
    @stripe_account = current_user.create_stripe_account(request.env["omniauth.auth"])
    redirect_url = session[:referrer_url] || dashboard_get_paid_path

    if @stripe_account
      redirect_to redirect_url, notice: "Thanks for connecting your Stripe accout. Now you can receive payments and donations!" 
    else
      redirect_to redirect_url, alert: t('errors.stripe_account.account_taken')
    end 
  end

  private

  def callback_of(provider)
    @user = User.find_user_from(request.env["omniauth.auth"])

    if @user.blank?
      session[:omniauth] = request.env["omniauth.auth"].except("extra")
      flash[:info] = t('flash.omniauth')
      redirect_to new_user_registration_url
    else
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    end
  end
end