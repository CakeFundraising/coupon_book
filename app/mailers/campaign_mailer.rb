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

  def commissions_transferred(campaign_id, amount_cents)
    @coupon_book = find_coupon_book(campaign_id)
    @fundraiser = @coupon_book.fundraiser
    @amount = amount_cents/100.0
    @date = Date.today.strftime("%m/%d/%Y")

    mail(to: @fundraiser.object.email, subject: "Your commission has been transferred!")
  end
end