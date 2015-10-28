class VoucherDecorator < ApplicationDecorator
  delegate_all
  decorates_association :coupon
  decorates_association :fundraiser

  def expires_at
    object.expires_at.strftime("%B %d, %Y") unless object.expires_at.nil?
  end

  def expires_at_american
    object.expires_at.strftime("%m/%d/%Y") unless object.expires_at.nil?
  end

  def fr_name
    purchasable.decorate.owner_name
  end

end