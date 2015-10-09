class AffiliateDecorator < ApplicationDecorator
  include AnalyticsDecorator
  delegate_all

  def to_s
    object.full_name
  end
end