class CouponBookDecorator < ApplicationDecorator
  delegate_all

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

  def goal
    h.humanized_money_with_symbol object.goal
  end

  def status
    object.status.titleize
  end

  def url_link
    h.auto_attr_link url, target: :_blank
  end
end
