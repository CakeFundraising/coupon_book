class CouponBooksController < InheritedResources::Base
  # before_action :set_coupon_book, only: [:show, :edit, :update, :destroy, :update_coupon_order]

  # GET /coupon_books
  def index
    @coupon_books = CouponBook.all
  end

  # GET /coupon_books/1
  def show
    @coupon_book = resource
    @collection = Collection.first
    @collections_coupons = CollectionsCoupon.where(collection_id: @collection.id)
    @categories = @coupon_book.categories
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
    book_categories = Category.where(coupon_book_id: @coupon_book.id)

    params[:categories].each do |id, category|
      position = category[:position]
      c = Category.find_by_id(id)
      c.insert_at(position.to_i)
    end


    filter = []
    if params[:categories_coupons]
      params[:categories_coupons].each do |id, category_coupon|
        position = category_coupon[:position]
        category = category_coupon[:category_id]
        coupon = category_coupon[:coupon_id]

        category_coupon = CategoriesCoupon.find_by_id(id)
        filter.push(id.to_i)

        if category_coupon.present?
          category_coupon.update_attributes(position: position, category_id: category)
          category_coupon.insert_at(position.to_i)

        else
          book_categories.each do |bc|
            CategoriesCoupon.where(category_id: bc, coupon_id: coupon).delete_all
          end
          category_coupon = CategoriesCoupon.create!(coupon_id: coupon, category_id: category, position: position)
          filter.push(category_coupon.id.to_i)
          category_coupon.insert_at(position.to_i)
        end
      end
    end


    cat_ids = []
    book_categories.each do |bc|
      cat_ids.push(bc.id)
    end

    @unused_coupons = CategoriesCoupon.select { |coupon|  cat_ids.include?(coupon.category_id) and (not filter.include?(coupon.id)) }

    @unused_coupons.each do |unused_coupon|
      CategoriesCoupon.destroy(unused_coupon.id)
    end

    redirect_to @coupon_book
  end

end
