class CouponCategoriesController < ApplicationController
  before_action :set_coupon_category, only: [:show, :edit, :update, :destroy]

  # GET /coupon_categories
  def index
    @coupon_categories = CouponCategory.all
  end

  # GET /coupon_categories/1
  def show
  end

  # GET /coupon_categories/new
  def new
    @coupon_category = CouponCategory.new(coupon_book_id: params[:coupon_book_id])
    @coupon_book = CouponBook.find(params[:coupon_book_id])
    # @coupon_category = CouponCategory.new
  end

  # GET /coupon_categories/1/edit
  def edit
  end

  # POST /coupon_categories
  def create
    @coupon_category = CouponCategory.new(coupon_category_params)
    # @coupon_book = CouponBook.find(@coupon_category.coupon_book)

    if @coupon_category.save
      redirect_to @coupon_category.coupon_book, notice: 'Coupon category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /coupon_categories/1
  def update
    if @coupon_category.update(coupon_category_params)
      redirect_to @coupon_category, notice: 'Coupon category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /coupon_categories/1
  def destroy
    @coupon_category.destroy
    redirect_to coupon_categories_url, notice: 'Coupon category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon_category
      @coupon_category = CouponCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coupon_category_params
      params.require(:coupon_category).permit(:name, :position, :coupon_book_id)
    end
end
