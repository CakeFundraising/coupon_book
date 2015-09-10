module AffiliatePageActions
  extend ActiveSupport::Concern
  
  included do
    before_action :allow_launched_book, only: :donate 
    before_action :redirect_old_slug, only: [:show]
  end

  def show
    @affiliate_campaign = AffiliateCampaign.preloaded.friendly.find(params[:id]).decorate
    @campaign = @affiliate_campaign.coupon_book

    if mobile_device?
      @first_category = @campaign.categories.first
      @discounts = @first_category.items.preloaded.decorate if @first_category.present?
      
      render("affiliate_campaigns/show/mobile/#{@campaign.template}/main", layout: 'layouts/books/mobile')
    else
      @categories = @campaign.categories.decorate
      @first_category = @categories.first
      @discounts = @first_category.items.object.preloaded.decorate if @first_category.present?
      @purchases = PurchaseDecorator.decorate_collection @campaign.purchases.latest.first(5)

      render("affiliate_campaigns/show/templates/#{@campaign.template}/main", layout: 'layouts/books/desktop')
    end
  end

  def donate
    @campaign = resource.decorate
    @purchases = PurchaseDecorator.decorate_collection @campaign.purchases.latest.first(5)
    @purchase = @campaign.purchases.build

    if mobile_device?
      render('affiliate_campaigns/donate/mobile', layout: 'layouts/books/mobile')
    else
      render('affiliate_campaigns/donate/desktop', layout: 'layouts/books/desktop')
    end
  end

  def checkout
    @campaign = resource.decorate
    @purchases = PurchaseDecorator.decorate_collection @campaign.purchases.latest.first(5)
    @purchase = @campaign.purchases.build(amount: @campaign.object.price.to_i)

    if mobile_device?
      render('affiliate_campaigns/checkout/mobile', layout: 'layouts/books/mobile')
    else
      render('affiliate_campaigns/checkout/desktop', layout: 'layouts/books/desktop')
    end
  end

  protected

  def allow_launched_book
    redirect_to campaign_path(resource) unless resource.launched?
  end

  def redirect_old_slug
    redirect_to resource, status: :moved_permanently if request.path != campaign_path(resource)
  end

end