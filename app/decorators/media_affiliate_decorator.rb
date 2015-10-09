class MediaAffiliateDecorator < ApplicationDecorator
  include AnalyticsDecorator

  def to_s
    object.name
  end
end