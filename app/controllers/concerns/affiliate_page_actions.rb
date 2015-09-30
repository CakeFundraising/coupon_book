module AffiliatePageActions
  extend ActiveSupport::Concern
  
  included do
    before_action :allow_launched_book, only: [:donate, :checkout]
    before_action :redirect_old_slug, only: [:show]
  end

  def show
    @affiliate_campaign = AffiliateCampaign.preloaded.friendly.find(params[:id]).decorate
    @coupon_book = @affiliate_campaign.coupon_book

    if mobile_device?
      @first_category = @coupon_book.categories.first
      @discounts = @first_category.items.preloaded.decorate if @first_category.present?
      
      render("affiliate_campaigns/show/mobile/#{@coupon_book.template}/main", layout: 'layouts/books/mobile')
    else
      @categories = @coupon_book.categories.decorate
      @first_category = @categories.first
      @discounts = @first_category.items.object.preloaded.decorate if @first_category.present?
      @purchases = PurchaseDecorator.decorate_collection @coupon_book.purchases.latest.first(5)

      render("affiliate_campaigns/show/templates/#{@coupon_book.template}/main", layout: 'layouts/books/desktop')
    end
  end

  def donate
    @affiliate_campaign = resource.decorate
    @coupon_book = @affiliate_campaign.coupon_book
    
    @purchases = PurchaseDecorator.decorate_collection @affiliate_campaign.purchases.latest.first(5)
    
    @purchase = @affiliate_campaign.purchases.build
    @commissions = @purchase.commissions.build(owner: @affiliate_campaign.affiliate)
    @commissions << @purchase.commissions.build(owner_type: 'MediaAffiliate', owner_id: cookies[:ma_id]) if cookies[:ma_id].present? #Media Affiliate Commission

    if mobile_device?
      render('affiliate_campaigns/donate/mobile', layout: 'layouts/books/mobile')
    else
      render('affiliate_campaigns/donate/desktop', layout: 'layouts/books/desktop')
    end
  end

  def checkout
    @affiliate_campaign = resource.decorate
    @coupon_book = @affiliate_campaign.coupon_book
    
    @purchases = PurchaseDecorator.decorate_collection @affiliate_campaign.purchases.latest.first(5)
    
    @purchase = @affiliate_campaign.purchases.build(amount: @coupon_book.object.price.to_i)
    @commissions = @purchase.commissions.build(owner: @affiliate_campaign.affiliate)
    @commissions << @purchase.commissions.build(owner_type: 'MediaAffiliate', owner_id: cookies[:ma_id]) if cookies[:ma_id].present? #Media Affiliate Commission

    if mobile_device?
      render('affiliate_campaigns/checkout/mobile', layout: 'layouts/books/mobile')
    else
      render('affiliate_campaigns/checkout/desktop', layout: 'layouts/books/desktop')
    end
  end

  protected

  def allow_launched_book
    redirect_to affiliate_campaign_path(resource) unless resource.coupon_book.launched?
  end

  def redirect_old_slug
    redirect_to resource, status: :moved_permanently if request.path != affiliate_campaign_path(resource)
  end

end