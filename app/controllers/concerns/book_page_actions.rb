module BookPageActions
  extend ActiveSupport::Concern
  
  included do
    before_action :allow_launched_book, only: :donate 
    before_action :redirect_old_slug, only: [:show, :donate]
  end

  def show
    @coupon_book = CouponBook.preloaded.friendly.find(params[:id]).decorate

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
    @coupon_book = resource.decorate
    @purchases = PurchaseDecorator.decorate_collection @coupon_book.purchases.latest.first(5)

    if mobile_device?
      render('coupon_books/donate/mobile', layout: 'layouts/books/mobile')
    else
      render('coupon_books/donate/desktop', layout: 'layouts/books/desktop')
    end
  end

  protected

  def allow_launched_book
    redirect_to coupon_book_path(resource) unless resource.launched?
  end

  def redirect_old_slug
    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    redirect_to resource, status: :moved_permanently if request.path != coupon_book_path(resource)
  end

end