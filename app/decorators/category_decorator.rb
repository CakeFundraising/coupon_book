class CategoryDecorator < ApplicationDecorator
  delegate_all
  decorates_association :coupons

  def to_s
    object.name
  end
end