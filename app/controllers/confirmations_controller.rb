class ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      sign_in(resource)
      respond_with_navigational(resource){ redirect_to after_confirmation_path }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end

  def after_confirmation_path
    home_get_started_path
  end

end