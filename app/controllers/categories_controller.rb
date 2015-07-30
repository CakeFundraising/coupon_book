class CategoriesController < InheritedResources::Base
  def new
    @category = Category.new(coupon_book_id: params[:coupon_book_id])
    @coupon_book = CouponBook.find(params[:coupon_book_id])
  end

  def create
    create! do |success, failure|
      success.html do
        redirect_to coupons_coupon_book_path(@category.coupon_book), notice: 'Category was successfully created.'
      end
    end
  end

  def update
    update! do |success, failure|
      success.html do
        redirect_to coupons_coupon_book_path(@category.coupon_book), notice: 'Category was successfully updated.'
      end
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html do
        redirect_to coupons_coupon_book_path(@category.coupon_book), notice: 'Category was successfully destroyed.'
      end
    end
  end

  #Discounts
  def discounts
    @category = resource
    @discounts = @category.items.preloaded.decorate
    render layout: false
  end

  def load_all_discounts
    @coupon_book = CouponBook.find(params[:coupon_book_id])

    @categories = @coupon_book.categories.with_items.to_a
    @categories.shift #remove first category
    @categories = CategoryDecorator.decorate_collection @categories

    render layout: false
  end

  private
  
  def category_params
    params.require(:category).permit(:name, :subtitle, :position, :coupon_book_id)
  end
end
