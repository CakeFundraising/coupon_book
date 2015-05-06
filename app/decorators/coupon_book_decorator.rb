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

  def current_sales
    h.humanized_money_with_symbol object.current_sales
  end

  def price
    h.humanized_money_with_symbol object.price
  end

  def goal
    h.humanized_money_with_symbol object.goal
  end

  def no_discount_price
    "$XXX"
  end

  def status
    object.status.titleize
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

  def url
    unless object.url.blank?
      (object.url=~/^https?:\/\//).nil? ? "http://#{object.url}" : object.url
    end
  end

  def url_link
    h.auto_attr_link url, target: :_blank
  end
end
