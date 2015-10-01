class CampaignMailer < ApplicationMailer

  def campaign_ended(campaign_id)
    @coupon_book = find_coupon_book(campaign_id)
    @fundraiser = @coupon_book.fundraiser

    mail(to: @fundraiser.object.email, subject: "Your EatsForGood Campaign has ended.")
  end

  def affiliate_invoices(campaign_id)
    @coupon_book = find_coupon_book(campaign_id)
    @fundraiser = @coupon_book.fundraiser
    @affiliate_campaigns = @coupon_book.affiliate_campaigns.decorate
    @media_campaigns = @coupon_book.media_affiliate_campaigns.decorate

    mail(to: @fundraiser.object.email, subject: "Reward your Campaign Affiliates!")
  end
end