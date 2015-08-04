module BookPageActions
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
      @purchases = PurchaseDecorator.decorate_collection @coupon_book.purchases.latest.first(5)

      render("coupon_books/show/templates/#{@coupon_book.template}/main", layout: 'layouts/books/desktop')
    end
  end

  def donate
    @coupon_book = CouponBook.find(params[:id]).decorate
    @purchases = PurchaseDecorator.decorate_collection @coupon_book.purchases.latest.first(5)

    if mobile_device?
      render('coupon_books/donate/mobile', layout: 'layouts/books/mobile')
    else
      render('coupon_books/donate/desktop', layout: 'layouts/books/desktop')
    end
  end
end