class CouponsController < InheritedResources::Base
  load_and_authorize_resource
  
  TEMPLATE_STEPS = [
    :sponsor,
    :discount,
    :launching
  ]

  def new
    @coupon = current_sponsor.present? ? Coupon.build_sp_coupon(current_sponsor) : Coupon.build_fr_coupon(current_fundraiser)
  end

  # Template Actions
  def discount
    @coupon = resource
    render 'coupons/template/discount'
  end

  def launching
    @coupon = resource.decorate
    render 'coupons/template/launch'
  end

  def launch
    path = current_sponsor.present? ? dashboard_sponsor_coupons_path : coupon_books_path
    redirect_to path, notice: 'Coupon was launched successfully!' if resource.launched!
  end

  def universal_toggle
    resource.toggle! :universal
    render nothing: true
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
    destroy! do |success, failure|
      success.html do
        path = current_sponsor.present? ? dashboard_sponsor_coupons_path : coupon_books_path
        redirect_to path, notice: 'Coupon was successfully destroyed.'
      end
    end
  end

  private

  def add_coupon_to_collection(coupon)
    # Add Coupon to FR collection when SP coupon
    CollectionsCoupon.create!(collection_id: params[:coupon][:fr_collection_id], coupon_id: coupon.id) if params[:coupon][:fr_collection_id].present?
  end

  def permitted_params
    params.permit(
      coupon: [
        :position, :title, :description, :promo_code, :terms, :url, :sponsor_url, 
        :multiple_locations, :phone, :expires_at, :coupon_book_id, :category_id,
        :price, :custom_terms, :sponsor_name, :collection_id, merchandise_categories: [],
        location_attributes: [:address, :city, :zip_code, :state_code, :country_code],
        avatar_picture_attributes: [
          :id, :uri, :caption, :avatar_crop_x, :avatar_crop_y, 
          :avatar_crop_w, :avatar_crop_h, :bypass_cloudinary_validation
        ],
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
