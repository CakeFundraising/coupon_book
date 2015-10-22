module AffiliatePageActions
  extend ActiveSupport::Concern
  
  included do
    before_action :validate_media_affiliate_token, only: [:donate, :checkout]
    before_action :redirect_old_slug, only: [:show]
  end

  def show
    @affiliate_campaign = AffiliateCampaign.preloaded.friendly.find(params[:id]).decorate
    @coupon_book = @affiliate_campaign.coupon_book
    @community = @affiliate_campaign.community.decorate

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
    purchase_method(:donate)
  end

  def checkout
    purchase_method(:checkout, true)
  end

  protected

  def purchase_method(method, pre_amount=false)
    @affiliate_campaign = resource.decorate
    @coupon_book = @affiliate_campaign.coupon_book
    
    @purchases = PurchaseDecorator.decorate_collection @affiliate_campaign.purchases.latest.first(5)

    amount = @coupon_book.object.price.to_i if pre_amount
    @purchase = @affiliate_campaign.purchases.build(amount: amount)

    @commissions = []
    @commissions << @purchase.commissions.build(commissionable: @affiliate_campaign, fcp: params[:fcp])
    @commissions << @purchase.commissions.build(commissionable_type: 'MediaAffiliateCampaign', commissionable_id: params[:macid]) if params[:macid].present? #Media Affiliate Commission

    if mobile_device?
      render("affiliate_campaigns/#{method}/mobile", layout: 'layouts/books/mobile')
    else
      render("affiliate_campaigns/#{method}/desktop", layout: 'layouts/books/desktop')
    end
  end

  def allow_launched_book
    redirect_to affiliate_campaign_path(resource) unless resource.coupon_book.launched?
  end

  def validate_media_affiliate_token
    if params[:macid].present?
      mac = MediaAffiliateCampaign.find_by_id(params[:macid])
      redirect_to request.path if mac.nil? or mac.try(:token) != params[:token]
    end
  end

  def redirect_old_slug
    redirect_to resource, status: :moved_permanently if request.path != affiliate_campaign_path(resource)
  end

end