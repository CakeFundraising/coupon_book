module MediaAffiliateCampaignTemplateController
  extend ActiveSupport::Concern
  include Referrer

  included do
    before_action :save_referrer, only: :get_paid, unless: ->{ current_media_affiliate.stripe_account? } 

    TEMPLATE_STEPS = [
      :community,
      :get_paid,
      :share,
    ]
  end

  def new
    @campaign = resource.decorate
  end

  def book_preview
    @community = Community.find(params[:community_id]).decorate
    @book = @community.coupon_book.decorate
    render partial:'media_affiliate_campaigns/template/partials/book_preview', layout: false
  end

  # def edit
  #   @campaign = resource.decorate
  #   @book = @campaign.coupon_book.decorate
  #   @community = @book.community.decorate
  # end

  def get_paid
    @campaign = resource.decorate
    @campaign.build_location(account_location_attrs) if @campaign.location.nil?
    render 'media_affiliate_campaigns/template/get_paid'
  end

  def share
    @campaign = resource.decorate
    @book = @campaign.coupon_book.decorate
    @community = @campaign.community.decorate
    render 'media_affiliate_campaigns/template/share'
  end

  private

  def account_location_attrs
    current_media_affiliate.location.attributes.except("id", "created_at", "updated_at", "locatable_type","locatable_id")
  end
end