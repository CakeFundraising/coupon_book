module AffiliateCampaignHelper
  def affiliate_campaign_edit_button(campaign)
    if can? :edit, campaign and not campaign.coupon_book.past?
      content_tag(:div, class:'container edit-buttons') do
        content_tag(:br)+
        link_to("Edit Campaign", join_affiliate_campaign_path(campaign), class:'btn btn-transparent-dark')
      end
    end
  end

  def affiliate_campaign_community_options
    CouponBook.commercial_or_community.affiliated.map{|cb| [cb.name, cb.community.id]}
  end

  def media_affiliate_campaign_community_options
    CouponBook.commercial_or_community.media_affiliated.map{|cb| [cb.name, cb.community.id]}
  end
end