class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  # GET /coupons
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

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      redirect_to @coupon, notice: 'Coupon was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /coupons/1
  def update
    if @coupon.update(coupon_params)
      redirect_to @coupon, notice: 'Coupon was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /coupons/1
  def destroy
    @coupon.destroy
    redirect_to coupons_url, notice: 'Coupon was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coupon_params
      params.require(:coupon).permit(:position, :title, :description, :promo_code, :terms_and_conditions, :url, :expires_at, :coupon_book_id, :coupon_category_id)
    end
end
