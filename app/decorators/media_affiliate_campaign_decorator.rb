class MediaAffiliateCampaignDecorator < ApplicationDecorator
  include AnalyticsDecorator
  include CampaignDecorator
  
  delegate_all

  decorates_association :coupon_book
  #decorates_association :media_affiliate

  def affiliate_name
    object.media_affiliate.full_name
  end

  def phone
    object.media_affiliate.phone
  end

  def commission_percentage
    "#{object.commission_percentage}%"
  end

  def community_page_url
    h.community_url(object.community, macid: object, token: object.token)   
  end 
end