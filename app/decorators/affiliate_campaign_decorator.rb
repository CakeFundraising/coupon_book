class AffiliateCampaignDecorator < ApplicationDecorator
  delegate_all

  decorates_association :coupon_book
  decorates_association :affiliate
  decorates_association :avatar_picture

  def to_s
    object.name
  end

  def affiliate_name
    object.organization_name || object.full_name
  end

  def end_date
    object.end_date.strftime("%m/%d/%Y") if object.end_date.present?
  end

  def current_sales
    h.humanized_money_with_symbol (object.current_sales_cents/100.0)
  end

  def current_commission_amount
    h.humanized_money_with_symbol (object.current_commission_cents/100.0)
  end

  def affiliate_commission_percentage
    "#{object.affiliate_commission_percentage}%"
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

  def status
    object.status.titleize
  end

  def give_path
    coupon_book.commercial_template? ? h.checkout_affiliate_campaign_path(self) : h.donate_affiliate_campaign_path(self)
  end

  def visitor_action
    "Join, Sign Up or Volunteer!"
  end

  def visitor_url
    url
  end
end