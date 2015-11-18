module BookPageActions
  extend ActiveSupport::Concern
  
  included do
    before_action :validate_media_affiliate_token, only: [:donate, :checkout]
    before_action :redirect_old_slug, only: [:show]
  end

  def show
    @coupon_book = CouponBook.preloaded.friendly.find(params[:id]).decorate

    if mobile_device?
      @first_category = @coupon_book.categories.first
      @discounts = @first_category.items.preloaded.decorate if @first_category.present?
      
      render("coupon_books/show/mobile/#{@coupon_book.template}/main", layout: 'layouts/books/mobile')
    else
      @categories = @coupon_book.categories.decorate
      @purchases = PurchaseDecorator.decorate_collection @coupon_book.purchases.latest.limit(10)

      render("coupon_books/show/templates/#{@coupon_book.template}/main", layout: 'layouts/books/desktop')
    end
  end

  def donate
    purchase_method(:donate)
  end

  def checkout
    purchase_method(:checkout, true)
  end

  protected

  def purchase_method(method, pre_amount=false)
    @coupon_book = resource.decorate
    @purchases = PurchaseDecorator.decorate_collection @coupon_book.purchases.latest.first(5)

    amount = @coupon_book.object.price.to_i if pre_amount
    @purchase = @coupon_book.purchases.build(amount: amount)

    @commissions = @purchase.commissions.build(commissionable_type: 'MediaAffiliateCampaign', commissionable_id: params[:macid]) if params[:macid].present? #Media Affiliate Commission

    if mobile_device?
      render("coupon_books/#{method}/mobile", layout: 'layouts/books/mobile')
    else
      render("coupon_books/#{method}/desktop", layout: 'layouts/books/desktop')
    end
  end

  def validate_media_affiliate_token
    if params[:macid].present?
      mac = MediaAffiliateCampaign.find_by_id(params[:macid])
      redirect_to request.path if mac.nil? or mac.try(:token) != params[:token]
    end
  end

  def allow_launched_book
    redirect_to coupon_book_path(resource) unless resource.launched?
  end

  def redirect_old_slug
    redirect_to resource, status: :moved_permanently if request.path != coupon_book_path(resource)
  end

end