class AvatarPictureDecorator < ApplicationDecorator
  delegate_all

  def uri(options={})
    if object.uri.present?
      classes = options.key?(:no_classes) ? '' : 'img-thumbnail img-responsive img-loaded'
      options = {crop: :crop, width: object.avatar_crop_w, height: object.avatar_crop_h, x: object.avatar_crop_x, y: object.avatar_crop_y, quality: "jpegmini:0", sign_url: true, class: classes}.merge options
      h.cl_image_tag(object.uri, options)
    else
      h.image_tag 'placeholder_avatar.png', class: 'img-thumbnail img-responsive img-default-avatar'
    end
  end

  def uri_path(options={})
    if object.uri.present?
      options = {crop: :crop, width: object.avatar_crop_w, height: object.avatar_crop_h, x: object.avatar_crop_x, y: object.avatar_crop_y, quality: "jpegmini:0", sign_url: true}.merge options
      h.cl_image_path(object.uri, options)
    else
      h.image_path 'placeholder_avatar.png', class: 'img-thumbnail img-responsive'
    end
  end
end