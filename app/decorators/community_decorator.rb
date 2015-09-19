class CommunityDecorator < ApplicationDecorator
  delegate_all

  def commission_percentage
    "#{object.commission_percentage}%"
  end

  def commission_value
    value = (object.commission_percentage*object.coupon_book.price)/100.0
    h.humanized_money_with_symbol value
  end

  def total_sales
    h.humanized_money_with_symbol (object.total_sales_cents/100.0)
  end
end