module CouponCategories
  extend ActiveSupport::Concern

  CATEGORIES = [
    'Food & Drink',
    'Home & Garden',
    'Services'
  ]

  def coupon_categories=(coupon_categories)
    coupon_categories = coupon_categories.split(",") if coupon_categories.is_a?(String)
    self.coupon_categories_mask = (coupon_categories & CATEGORIES).map { |r| 2**CATEGORIES.index(r) }.inject(0, :+)
  end

  def coupon_categories
    CATEGORIES.reject do |r|
      ((coupon_categories_mask.to_i || 0) & 2**CATEGORIES.index(r)).zero?
    end
  end

  def has_coupon_category?(coupon_category)
    coupon_categories.include?(coupon_category)
  end
end