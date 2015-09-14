module AffiliateCampaignHelper
  def affiliate_campaign_edit_button(campaign)
    if can? :edit, campaign and not campaign.coupon_book.past?
      link_to "Edit Campaign", edit_affiliate_campaign_path(campaign), class:'btn btn-transparent-dark'
    end
  end
end