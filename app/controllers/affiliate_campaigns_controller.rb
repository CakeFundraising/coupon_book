class AffiliateCampaignsController < InheritedResources::Base
  include AffiliateCampaignTemplateController
  load_and_authorize_resource

  def index
    @campaigns = current_affiliate.affiliate_campaigns.latest.decorate
  end
end