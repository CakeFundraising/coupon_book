class RegistrationsController < Devise::RegistrationsController
  before_action :store_redirect_url, only: :new

  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end

    unless @user.new_record?
      session[:omniauth] = nil
      session[:user_role] = nil
    end
  end

  private

  def build_resource(*args)
    @user = User.new_with(session[:omniauth], args.first)
  end

  def after_sign_up_path_for(resource)
    root_path
  end

  def store_redirect_url
    session[:redirect_to] = params[:redirect_to] if params[:redirect_to].present?
  end
end