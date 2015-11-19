module CouponsHelper
  def coupon_pic(coupon)
    if coupon.url.nil?
      coupon.main_pic
    else
      # Link with rollover
      picture_rollover(coupon.main_pic, coupon.url) do
        content_tag(:div, 'Click to learn more') + content_tag(:div, 'about this offer!')
      end
    end
  end

  def coupon_main_location(coupon)
    content_tag(:div, class:'coupon_location') do
      content_tag(:div, coupon.address) + 
      content_tag(:div, coupon.main_location) 
    end
  end

  def coupon_sp_pic(coupon)
    picture_rollover(coupon.sp_pic, coupon.url) do
      content_tag(:div, 'Visit our') + content_tag(:div, 'website!')
    end
  end

  def coupon_see_all_pic(coupon)
    picture_ajax_rollover(coupon.sp_pic) do
      link_to('#!', class:'expand see-more-box') do
        content_tag(:div, 'See all') + content_tag(:div, 'Deals')
      end
    end
  end

  def coupon_print_button(coupon)
    link_to download_coupon_path(coupon), class:'btn btn-primary coupon_print_button extra_click_link' do
      content_tag(:span, nil, class: 'glyphicon glyphicon-print') +
      content_tag(:span, ' Print Coupon')
    end
  end

  def edit_item_path(item)
    item.coupon? ? edit_coupon_path(item) : edit_pr_box_path(item)
  end
end