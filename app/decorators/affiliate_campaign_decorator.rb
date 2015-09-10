class AffiliateCampaignDecorator < ApplicationDecorator
  delegate_all

  decorates_association :coupon_book

  def to_s
    object.name
  end

  def end_date
    object.end_date.strftime("%m/%d/%Y") if object.end_date.present?
  end

  def current_sales
    h.humanized_money_with_symbol (object.current_sales_cents/100.0)
  end
end