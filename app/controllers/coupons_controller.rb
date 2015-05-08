class CouponsController < InheritedResources::Base
  TEMPLATE_STEPS = [
    :sponsor,
    :discount,
    :news,
    :launch
  ]

  # Template Actions
  def discount
    @coupon = resource.decorate
    render 'coupons/template/discount'
  end

  #CRUD actions
  def create
    create! do |success, failure|
      success.html do
        #update_screenshot(@coupon)
        add_coupon_to_collection(resource)
        redirect_to discount_coupon_path(@coupon)
      end
      failure.html do
        render action: :new
      end
    end
  end

  def update
    update! do |success, failure|
      success.html do
        #update_screenshot(@coupon)
        redirect_to controller: :coupons, action: params[:coupon][:step], id: resource
      end
      failure.html do
        step_action = TEMPLATE_STEPS[TEMPLATE_STEPS.index(params[:coupon][:step].to_sym)-1].to_s
        render 'coupons/template/' + step_action
      end
    end
  end

  # DELETE /coupons/1
  def destroy
    @coupon.destroy
    redirect_to coupons_url, notice: 'Coupon was successfully destroyed.'
  end

  private

  def add_coupon_to_collection(coupon)
    current_role = current_fundraiser || current_sponsor
    CollectionsCoupon.create!(collection_id: current_role.coupon_collection.id, coupon_id: coupon.id)
  end

  def permitted_params
    params.permit(
      coupon: [
        :position, :title, :description, :promo_code, :terms, :url, :sponsor_url, 
        :multiple_locations, :phone, :expires_at, :coupon_book_id, :category_id,
        location_attributes: [:address, :city, :zip_code, :state_code],
        picture_attributes: [
          :id, :banner, :avatar, :qrcode, :avatar_caption,
          :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h,
          :banner_crop_x, :banner_crop_y, :banner_crop_w, :banner_crop_h,
          :qrcode_crop_x, :qrcode_crop_y, :qrcode_crop_w, :qrcode_crop_h
        ]
      ]
    )
  end
end
