class PrBoxDecorator < ApplicationDecorator
  delegate_all
  decorates_association :picture
  decorates_association :owner, with: FundraiserDecorator

  def trunc_title(length=37)
    h.truncate(object.title, length: length, separator: ' ').html_safe unless object.title.nil?
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