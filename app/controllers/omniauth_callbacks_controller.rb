class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_of("Facebook")
  end

  def twitter
    callback_of("Twitter")
  end

  def stripe_connect
    if current_fundraiser.present?
      @stripe_account = current_fundraiser.create_stripe_account(request.env["omniauth.auth"])

      if @stripe_account
        redirect_to dashboard_get_paid_path, notice: "Thanks for connecting your Stripe accout. Now you can receive payments and donations!" 
      else
        redirect_to dashboard_get_paid_path, alert: t('errors.stripe_account.account_taken')
      end 
    elsif current_affiliate.present?
      @stripe_account = current_affiliate.create_stripe_account(request.env["omniauth.auth"])
      
      if @stripe_account
        redirect_to dashboard_get_paid_path, notice: "Please add your credit card data to make automatic payments. This sensitive information is not being saved in our servers." 
      else
        redirect_to dashboard_get_paid_path, alert: t('errors.stripe_account.account_taken')
      end
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