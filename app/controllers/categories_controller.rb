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
    @category = resource.decorate
    @discounts = @category.items.preloaded
  end

  private
  
  def category_params
    params.require(:category).permit(:name, :subtitle, :position, :coupon_book_id)
  end
end
