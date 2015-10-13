class MediaAffiliateCampaignMailer < ApplicationMailer

  def commissions_transferred(campaign_id, amount_cents)
    @campaign = MediaAffiliateCampaign.find(campaign_id).decorate
    @affiliate = @campaign.media_affiliate
    @amount = amount_cents/100.0
    @date = Date.today.strftime("%m/%d/%Y")

    mail(to: @affiliate.email, subject: "Your commission has been transferred!")
  end
end