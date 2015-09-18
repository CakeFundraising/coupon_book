class AffiliateDecorator < ApplicationDecorator
  delegate_all

  def to_s
    object.full_name
  end
end