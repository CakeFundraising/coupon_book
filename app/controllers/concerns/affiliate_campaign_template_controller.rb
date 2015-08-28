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

  def edit
    @campaign = resource.decorate
  end

  def join
    @campaign = resource.decorate
    render 'affiliate_campaigns/template/join'
  end

  def get_paid
    @campaign = resource.decorate
    render 'affiliate_campaigns/template/get_paid'
  end

  def share
    @campaign = resource.decorate
    render 'affiliate_campaigns/template/share'
  end

end