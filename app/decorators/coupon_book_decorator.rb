class CouponBookDecorator < ApplicationDecorator
  delegate_all

  def to_s
    'Coupon Book'
  end
end
