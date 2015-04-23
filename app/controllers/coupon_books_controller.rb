class CouponBooksController < InheritedResources::Base
  # before_action :set_coupon_book, only: [:show, :edit, :update, :destroy, :update_coupon_order]

  # GET /coupon_books
  def index
    @coupon_books = CouponBook.all
  end

  # GET /coupon_books/1
  def show
    @collection = Collection.first
    @collections_coupons = CollectionsCoupon.where(collection_id: @collection.id)
    @categories = Category.where(coupon_book_id: resource.id)
    p @categories.inspect
    @categories_coupons = CategoriesCoupon.all
    # @categories_coupons = CategoriesCoupon.where(category_id: )
  end

  # GET /coupon_books/new
  def new
    @coupon_book = CouponBook.new
    @collection = Collection.create!
  end

  # GET /coupon_books/1/edit
  def edit
  end

  # POST /coupon_books
  def create
    create! do |success, failure|
      success.html do
        redirect_to resource
      end
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

  def update_coupon_book_order
    @coupon_book = CouponBook.find(params[:id])

    update_categories_order

    # filter = []
    # if params[:categories_coupons]
    #   params[:categories_coupons].each do |categories_coupon, vals|
    #     position = vals[:position]
    #     category_id = vals[:category_id]
    #     coupon_id = vals[:coupon_id]
    #
    #     categories_coupon = CategoriesCoupon.find_by(category_id: category_id, coupon_id: coupon_id)
    #
    #     if categories_coupon.nil?
    #       CategoriesCoupon.create!(category_id: category_id, coupon_id: coupon_id, position: position)
    #     else
    #       categories_coupon.update_attribute(:position, position)
    #       categories_coupon.insert_at(position.to_i)
    #     end
    #     filter.push(coupon_id.to_i)
    #
    #
    #
    #
    #   end
    #
    # end

    # @unused_coupons = Coupon.all.select { |coupon| not filter.include?(coupon.id) }
    #
    # @unused_coupons.each do |unused_coupon|
    #   unused_coupon.update_attribute(:category_id, 0)
    # end

    redirect_to @coupon_book
  end

  private

  def update_categories_order
    params[:categories].each do |id, category|
      position = category[:position]
      c = Category.find(id)
      c.insert_at(position.to_i)
    end

  end


    # # Use callbacks to share common setup or constraints between actions.
    # def set_coupon_book
    #   @coupon_book = CouponBook.find(params[:id])
    # end
    #
    # # Only allow a trusted parameter "white list" through.
    # def coupon_book_params
    #   params[:coupon_book]
    # end
end
