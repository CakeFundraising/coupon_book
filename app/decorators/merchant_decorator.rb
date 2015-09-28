class MerchantDecorator < ApplicationDecorator
  delegate_all

  decorates_association :avatar_picture

  def to_s
    object.full_name
  end

  def location
    object.location.to_s
  end

  def coupons_count
    object.coupons.count
  end
end