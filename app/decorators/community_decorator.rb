class CommunityDecorator < ApplicationDecorator
  delegate_all

  decorates_association :coupon_book

  def to_s
    coupon_book
  end

  def affiliate_commission_percentage
    "#{object.affiliate_commission_percentage}%"
  end

  def media_commission_percentage
    "#{object.media_commission_percentage}%"
  end

  def affiliate_commission_value
    value = (object.affiliate_commission_percentage*object.coupon_book.price)/100.0
    h.humanized_money_with_symbol value
  end

  def media_commission_value
    value = (object.media_commission_percentage*object.coupon_book.price)/100.0
    h.humanized_money_with_symbol value
  end

  def total_sales
    h.humanized_money_with_symbol (object.total_sales_cents/100.0)
  end
end