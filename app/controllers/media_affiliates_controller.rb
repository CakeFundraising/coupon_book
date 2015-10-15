class MediaAffiliatesController < InheritedResources::Base
  include AccountController

  protected

  def permitted_params
    params.permit(media_affiliate: [
      :first_name, :last_name, :organization_name, :email, :phone, :tax_exempt, :url,
      location_attributes: [:address, :city, :zip_code, :state_code, :country_code],
      avatar_picture_attributes: [
        :id, :uri, :caption, :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h, :bypass_cloudinary_validation
      ]
    ])
  end
end