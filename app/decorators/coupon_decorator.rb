class CouponDecorator < ApplicationDecorator
  delegate_all
  decorates_association :picture
  decorates_association :avatar_picture
  decorates_association :location
  decorates_association :owner, with: FundraiserDecorator

  def trunc_title(length=37)
    h.truncate(object.title, length: length, separator: ' ').html_safe unless object.title.nil?
  end

  def trunc_description
    h.truncate(object.description, length: 75).html_safe unless object.description.nil?
  end

  def expires_at
    object.expires_at.strftime("%B %d, %Y") unless object.expires_at.nil?
  end

  def expires_at_american
    object.expires_at.strftime("%m/%d/%Y") unless object.expires_at.nil?
  end

  def to_s
    object.try(:title) || 'No title'
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

  def address
    object.location.address
  end

  def main_location
    object.location.to_s
  end

  def multiple_locations
    "* Valid at the following locations: #{object.multiple_locations}" unless object.multiple_locations.blank?
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

  def universal
    h.b object.universal
  end

  def terms
    object.custom_terms || 'None.'
  end

  #Pics
  def sp_pic(options={})
    pic = object.avatar_picture

    if pic.uri.present?
      classes = options.key?(:no_classes) ? '' : 'img-thumbnail img-responsive img-loaded'
      transformations = [
        {crop: :crop, width: pic.avatar_crop_w, height: pic.avatar_crop_h, x: pic.avatar_crop_x, y: pic.avatar_crop_y},
        :coupon_grid_sp
      ]
      h.cl_image_tag(pic.uri, sign_url: true, transformation: transformations, quality: :jpegmini, class: classes)
    else
      h.image_tag 'placeholder_avatar.png', class: 'img-thumbnail img-responsive img-default-avatar'
    end
  end

  def main_pic(options={})
    pic = object.picture

    if pic.avatar.present?
      classes = options.key?(:no_classes) ? '' : 'img-thumbnail img-responsive img-loaded'
      transformations = [
        {crop: :crop, width: pic.avatar_crop_w, height: pic.avatar_crop_h, x: pic.avatar_crop_x, y: pic.avatar_crop_y},
        :coupon_rectangle_main
      ]
      h.cl_image_tag(pic.avatar, sign_url: true, transformation: transformations, quality: :jpegmini, class: classes)
    else
      h.image_tag 'placeholder_avatar.png', class: 'img-thumbnail img-responsive img-default-avatar'
    end
  end
end