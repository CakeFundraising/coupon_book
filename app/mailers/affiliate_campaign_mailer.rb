class AffiliateCampaignMailer < ApplicationMailer

  def commissions_transferred(campaign_id, amount_cents)
    @campaign = AffiliateCampaign.find(campaign_id).decorate
    @affiliate = @campaign.affiliate
    @amount = amount_cents/100.0
    @date = Date.today.strftime("%m/%d/%Y")

    mail(to: @affiliate.object.email, subject: "Your commission has been transferred!")
  end
end