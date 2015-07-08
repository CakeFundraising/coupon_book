class PrBoxDecorator < ApplicationDecorator
  delegate_all
  decorates_association :picture
  decorates_association :owner, with: FundraiserDecorator

  def trunc_title
    h.truncate(object.title, length: 37).html_safe
  end

  def trunc_description
    h.truncate(object.description, length: 100).html_safe
  end

  def to_s
    object.title
  end

  def url
    unless object.url.blank?
      (object.url=~/^https?:\/\//).nil? ? "http://#{object.url}" : object.url
    end
  end
end