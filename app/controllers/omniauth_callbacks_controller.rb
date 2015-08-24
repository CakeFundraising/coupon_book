class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_of("Facebook")
  end

  def twitter
    callback_of("Twitter")
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