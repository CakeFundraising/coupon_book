module CouponsHelper
  def coupon_pic(coupon)
    if coupon.url.nil?
      coupon.picture.avatar
    else
      # Link with rollover
      picture_rollover(coupon.picture.avatar, coupon.url) do
        content_tag(:div, 'Click to learn more') + content_tag(:div, 'about this offer!')
      end
    end
  end

  def coupon_sp_pic(coupon)
    picture_rollover(coupon.avatar_picture.uri, coupon.sponsor_url) do
      content_tag(:div, 'Visit our') + content_tag(:div, 'website!')
    end
  end

  def coupon_print_button(coupon)
    link_to download_coupon_path(coupon), class:'btn btn-primary coupon_print_button extra_click_link' do
      content_tag(:span, nil, class: 'glyphicon glyphicon-print') +
      content_tag(:span, ' Print Coupon')
    end
  end
end