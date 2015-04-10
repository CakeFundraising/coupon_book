class CouponsController < InheritedResources::Base

  def index
    @coupons = Coupon.all
  end

  # GET /coupons/1
  def show
  end

  # GET /coupons/new
  def new
    @coupon_category = CouponCategory.find(params[:coupon_category_id])
    @coupon_book = @coupon_category.coupon_book
    @coupon = Coupon.new(coupon_book_id: @coupon_book.id, coupon_category_id: @coupon_category.id)
    # @coupon = Coupon.new
  end

  def edit
    @coupon = resource
  end

  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      redirect_to @coupon, notice: 'Coupon was successfully created.'
    else
      render :new
    end
  end

  # # PATCH/PUT /coupons/1
  # def update
  #   if @coupon.update(coupon_params)
  #     redirect_to @coupon, notice: 'Coupon was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  def update
    update! do |success, failure|
      success.html do
        redirect_to coupon_book_path(resource.coupon_book)
      end
      failure.html do
        @coupon_book = resource.coupon_book
        render :edit
      end
    end
  end

  # DELETE /coupons/1
  def destroy
    @coupon.destroy
    redirect_to coupons_url, notice: 'Coupon was successfully destroyed.'
  end

  def download
    # extra_click(resource.url, resource.pledge, redirect=false)

    # respond_with(resource) do |format|
    #   format.html do
    #     pdf = CouponPdf.new(resource.decorate)
    #     send_data pdf.render, filename: "#{resource.sponsor.name.titleize}-#{resource.title.titleize}.pdf", type: 'application/pdf'
    #   end
    # end
  end


  def permitted_params
    params.permit(
      coupon: [
        :position, :title, :description, :promo_code, :terms_and_conditions, :url, :expires_at, :coupon_book_id, :coupon_category_id,
        picture_attributes: [
          :id, :banner, :avatar, :qrcode, :avatar_caption,
          :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h,
          :banner_crop_x, :banner_crop_y, :banner_crop_w, :banner_crop_h,
          :qrcode_crop_x, :qrcode_crop_y, :qrcode_crop_w, :qrcode_crop_h
        ]
      ]
    )
  end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_coupon
  #     @coupon = Coupon.find(params[:id])
  #   end
  #
  #   # Only allow a trusted parameter "white list" through.
  #   def coupon_params
  #     params.require(:coupon).permit(:position, :title, :description, :promo_code, :terms_and_conditions, :url, :expires_at, :coupon_book_id, :coupon_category_id)
  #   end
end
