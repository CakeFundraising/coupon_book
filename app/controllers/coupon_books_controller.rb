class CouponBooksController < ApplicationController
  before_action :set_coupon_book, only: [:show, :edit, :update, :destroy, :update_coupon_order]

  # GET /coupon_books
  def index
    @coupon_books = CouponBook.all
  end

  # GET /coupon_books/1
  def show
    @coupon_categories = @coupon_book.coupon_categories
  end

  # GET /coupon_books/new
  def new
    @coupon_book = CouponBook.new
  end

  # GET /coupon_books/1/edit
  def edit
  end

  # POST /coupon_books
  def create
    @coupon_book = CouponBook.new(coupon_book_params)

    if @coupon_book.save
      redirect_to @coupon_book, notice: 'Coupon book was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /coupon_books/1
  def update
    if @coupon_book.update(coupon_book_params)
      redirect_to @coupon_book, notice: 'Coupon book was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /coupon_books/1
  def destroy
    @coupon_book.destroy
    redirect_to coupon_books_url, notice: 'Coupon book was successfully destroyed.'
  end

  def update_coupon_order
    @coupon_book = CouponBook.find(params[:id])

    params[:coupon_categories].each do |cat_id, vals|
      position = vals[:position]

      category = CouponCategory.find(cat_id)

      category.insert_at(position.to_i)
    end

    params[:coupons].each do |coupon_id, vals|
      position = vals[:position]
      category_id = vals[:coupon_category_id]

      coupon = Coupon.find(coupon_id)

      coupon.update_attribute(:coupon_category_id, category_id)

      coupon.insert_at(position.to_i)
    end

    redirect_to @coupon_book
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon_book
      @coupon_book = CouponBook.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coupon_book_params
      params[:coupon_book]
    end
end
