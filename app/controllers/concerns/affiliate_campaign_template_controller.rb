module AffiliateCampaignTemplateController
  extend ActiveSupport::Concern

  included do
    TEMPLATE_STEPS = [
      :campaign,
      :join,
      :get_paid,
      :share,
    ]
  end

  def new
    @campaign = resource.decorate
  end

  def book_preview
    @book = CouponBook.find(params[:coupon_book_id]).decorate
    @community = @book.community.decorate
    render partial:'affiliate_campaigns/template/partials/book_preview', layout: false
  end

  def edit
    @campaign = resource.decorate
    @book = @campaign.coupon_book.decorate
    @community = @book.community.decorate
  end

  def join
    @campaign = campaign_with_account_data.decorate
    render 'affiliate_campaigns/template/join'
  end

  def get_paid
    @campaign = resource.decorate
    @campaign.build_location(account_location_attrs) if @campaign.location.nil?
    render 'affiliate_campaigns/template/get_paid'
  end

  def share
    @campaign = resource.decorate
    @book = @campaign.coupon_book.decorate
    render 'affiliate_campaigns/template/share'
  end

  private

  def campaign_with_account_data
    if resource.first_name.blank?
      account = current_affiliate
      resource.first_name = account.first_name
      resource.last_name = account.last_name
      resource.phone = account.phone
      resource.email = account.email
    end
    resource
  end

  def account_location_attrs
    current_affiliate.location.attributes.except("id", "created_at", "updated_at", "locatable_type","locatable_id")
  end

end