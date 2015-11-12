class CommunityDecorator < ApplicationDecorator
  delegate_all
  decorates_association :coupon_book

  delegate :no_discount_price, :price, :to_s, :fr_name, to: :coupon_book

  def titleized_slug
    object.slug.titleize
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

  def shareable_screenshot_url
    object.screenshot_url.split('url2png').join('url2png/w_1200,h_600,c_fill,g_north,r_10') unless object.screenshot_url.blank?
  end
end