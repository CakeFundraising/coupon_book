class CouponBookDecorator < ApplicationDecorator
  include AnalyticsDecorator
  include CampaignDecorator
  
  delegate_all

  decorates_association :picture
  decorates_association :video
  decorates_association :fundraiser, with: FundraiserDecorator

  def end_date_countdown
    object.end_date.strftime("%Y/%m/%d %H:%M:%S")
  end

  def start_end_dates
    "#{launch_date} to #{end_date}"
  end

  def fr_name
    (object.organization_name || object.fundraiser.full_name)
  end

  def no_discount_price
    h.humanized_money_with_symbol object.no_discount_price
  end

  def causes
    object.causes.join(", ")
  end

  def scopes
    object.scopes.join(", ")
  end

  def location
    [object.fundraiser.location.city, object.fundraiser.location.state_code].join(', ')
  end

  def visitor_action
    return "Join, Sign Up or Volunteer!" if object.visitor_action.blank?
    object.visitor_action
  end

  def visitor_url
    unless object.visitor_url.blank?
      (object.visitor_url=~/^https?:\/\//).nil? ? "http://#{object.visitor_url}" : object.visitor_url
    end
  end

  def visitor_url_link
    h.auto_attr_link visitor_url, target: :_blank
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

  def donations_raised
    h.humanized_money_with_symbol object.donations_raised
  end
  
  def total_donations_and_sales
    h.humanized_money_with_symbol object.total_donations_and_sales
  end

  def purchases_count
    count = object.purchases.count + object.affiliate_purchases.count
    h.number_to_human(count, units: :numbers, format: '%n%u')
  end
end
