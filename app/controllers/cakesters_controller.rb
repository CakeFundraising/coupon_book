class CakestersController < InheritedResources::Base
  include AccountController

  def update
    update! do |success, failure|
      success.html do
        #send_notification
        redirect_to dashboard_dashboard_path, notice: 'Profile updated.'
      end
    end
  end

  protected

  def permitted_params
    params.permit(cakester: [
      :first_name, :last_name, :email, :phone, :tax_exempt,
      location_attributes: [:address, :city, :zip_code, :state_code, :country_code],
      avatar_picture_attributes: [
        :id, :uri, :caption, :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h
      ]
    ])
  end
end