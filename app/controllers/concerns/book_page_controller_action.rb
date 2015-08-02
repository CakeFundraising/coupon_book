module BookPageControllerAction
  def show
    @coupon_book = CouponBook.preloaded.find(params[:id]).decorate

    if mobile_device?
      @first_category = @coupon_book.categories.first
      @discounts = @first_category.items.preloaded.decorate
      
      render(:mobile_show, layout: 'layouts/books/mobile')
    else
      @categories = @coupon_book.categories.decorate
      @first_category = @categories.first
      @discounts = @first_category.items.object.preloaded.decorate if @first_category.present?

      render("coupon_books/show/templates/#{@coupon_book.template}/main", layout: 'layouts/books/desktop')
    end
  end
end