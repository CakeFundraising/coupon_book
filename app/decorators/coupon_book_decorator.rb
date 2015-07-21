class CouponBookDecorator < ApplicationDecorator
  delegate_all

  decorates_association :picture
  decorates_association :video
  decorates_association :fundraiser, with: FundraiserDecorator

  def launch_date
    object.launch_date.strftime("%m/%d/%Y") if object.launch_date.present?
  end

  def end_date
    object.end_date.strftime("%m/%d/%Y") if object.end_date.present?
  end

  def end_date_countdown
    object.end_date.strftime("%Y/%m/%d %H:%M:%S")
  end

  def start_end_dates
    "#{launch_date} to #{end_date}"
  end

  def to_s
    object.name
  end

  def fr_name
    (object.organization_name || object.fundraiser.name)
  end

  def current_sales
    h.humanized_money_with_symbol (object.current_sales_cents/100.0)
  end

  def price
    h.humanized_money_with_symbol object.price
  end

  def goal
    h.humanized_money_with_symbol object.goal
  end

  def no_discount_price
    h.humanized_money_with_symbol object.no_discount_price
  end

  def status
    object.status.titleize
  end

  def causes
    object.causes.join(", ")
  end

  def scopes
    object.scopes.join(", ")
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
end
