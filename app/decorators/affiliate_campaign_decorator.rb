class AffiliateCampaignDecorator < ApplicationDecorator
  include AnalyticsDecorator
  include CampaignDecorator
  
  delegate_all

  decorates_association :coupon_book
  decorates_association :affiliate
  decorates_association :avatar_picture

  def affiliate_name
    object.organization_name || object.full_name
  end

  def fr_name
    coupon_book.fr_name
  end

  def owner_name
    coupon_book.commercial_template? ? fr_name : affiliate_name
  end

  def community_rate
    "#{object.community_rate}%"
  end

  def campaign_rate
    "#{object.campaign_rate}%"
  end

  def meta_title
    book = coupon_book
    book.commercial_template? ? book.fr_name : object.organization_name
  end

  def url
    unless object.url.blank?
      (object.url=~/^https?:\/\//).nil? ? "http://#{object.url}" : object.url
    end
  end

  def url_link
    h.auto_attr_link url, target: :_blank
  end

  def shareable_screenshot_url
    object.screenshot_url.split('url2png').join('url2png/w_1200,h_600,c_fill,g_north,r_10') unless object.screenshot_url.blank?
  end

  def give_path(params)
    coupon_book.commercial_template? ? h.checkout_affiliate_campaign_path(self, params) : h.donate_affiliate_campaign_path(self, params)
  end

  def visitor_action
    "Join, Sign Up or Volunteer!"
  end

  def visitor_url
    url
  end

  def avatar_pic_path
    object.avatar_picture.present? ? avatar_picture.uri_path : coupon_book.picture.avatar_path
  end
end