class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /coupon_categories
  def index
    @categories = Category.all
  end

  # GET /coupon_categories/1
  def show
  end

  # GET /coupon_categories/new
  def new
    @category = Category.new(coupon_book_id: params[:coupon_book_id])
    @coupon_book = CouponBook.find(params[:coupon_book_id])
    # @coupon_category = CouponCategory.new
  end

  # GET /coupon_categories/1/edit
  def edit
  end

  # POST /coupon_categories
  def create
    @category = Category.new(category_params)
    # @coupon_book = CouponBook.find(@coupon_category.coupon_book)

    if @category.save
      redirect_to @category.coupon_book, notice: 'Coupon category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /coupon_categories/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Coupon category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /coupon_categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Coupon category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :position, :coupon_book_id)
    end
end
