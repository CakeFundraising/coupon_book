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

  #Pics
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