module CouponBookHelper
  def hidden_coupon_book_cancel_link
    link_to 'Cancel', @coupon_book, method: :delete, class:'hidden', id: 'hidden_delete_link'
  end

  def status_buttons(coupon_book)
    if coupon_book.pending?
      content_tag :span do
        link_to "Launch", launch_coupon_book_path(coupon_book), method: :patch, remote: true, class:'btn btn-success btn-sm launch_button'
      end
    elsif coupon_book.incomplete?
      content_tag(:div, coupon_book.status, class:'btn btn-sm btn-danger disabled')
    else
      content_tag(:div, coupon_book.status, class:'btn btn-sm btn-success disabled')
    end
  end

  def visibility_buttons(coupon_book)
    content_tag :div, class:'visibility_buttons' do
      content_tag :span do
        link_to("Hide", toggle_visibility_coupon_book_path(coupon_book), method: :patch, remote: true, class:"btn btn-danger btn-sm #{'hidden' unless coupon_book.visible}")+
        link_to("Show", toggle_visibility_coupon_book_path(coupon_book), method: :patch, remote: true, class:"btn btn-success btn-sm #{'hidden' if coupon_book.visible}")
      end
    end
  end

  def buy_coupon_book_button(cb, options={})
    link_to "#{cb.price} Buy Now!", nil, options
  end
end