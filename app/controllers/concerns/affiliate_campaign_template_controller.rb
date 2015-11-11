module AffiliateCampaignTemplateController
  extend ActiveSupport::Concern
  include Referrer

  included do
    before_action :save_referrer, only: :get_paid, unless: ->{ current_affiliate.stripe_account? } 

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
    @community = Community.find(params[:community_id]).decorate
    @book = @community.coupon_book.decorate
    render partial:'affiliate_campaigns/template/partials/book_preview', layout: false
  end

  # def edit
  #   @campaign = resource.decorate
  #   @book = @campaign.coupon_book.decorate
  #   @community = @book.community.decorate
  # end

  def join
    @campaign = campaign_with_account_data
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