class CouponDecorator < ApplicationDecorator
  delegate_all
  decorates_association :picture
  decorates_association :avatar_picture
  decorates_association :location
  decorates_association :owner, with: FundraiserDecorator

  def trunc_title
    h.truncate(object.title, length: 37).html_safe
  end

  def trunc_description
    h.truncate(object.description, length: 75).html_safe
  end

  def expires_at
    object.expires_at.strftime("%B %d, %Y") unless object.expires_at.nil?
  end

  def expires_at_american
    object.expires_at.strftime("%m/%d/%Y") unless object.expires_at.nil?
  end

  def to_s
    object.title
  end

  def price
    h.humanized_money_with_symbol object.price
  end

  def url
    unless object.url.blank?
      (object.url=~/^https?:\/\//).nil? ? "http://#{object.url}" : object.url
    end
  end

  def url_link
    h.auto_attr_link url, target: :_blank
  end

  def sponsor_url
    unless object.sponsor_url.blank?
      (object.sponsor_url=~/^https?:\/\//).nil? ? "http://#{object.sponsor_url}" : object.sponsor_url
    end
  end

  def address
    object.location.address
  end

  def main_location
    object.location.to_s
  end

  def multiple_locations
    "* Valid at the following locations: #{object.multiple_locations}"
  end

  def retail_value
    h.humanized_money_with_symbol object.price
  end

  def location
    object.multiple_locations.blank? ? main_location : object.multiple_locations
  end

  def status
    object.status.titleize
  end
end