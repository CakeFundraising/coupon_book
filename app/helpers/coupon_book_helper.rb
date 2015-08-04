module CouponBookHelper
  def hidden_coupon_book_cancel_link
    link_to 'Cancel', @coupon_book, method: :delete, class:'hidden', id: 'hidden_delete_link'
  end

  def status_buttons(coupon_book)
    unless coupon_book.past?
      if coupon_book.pending?
        link_to("Launch", launch_coupon_book_path(coupon_book), method: :patch, remote: true, class:'btn btn-success btn-sm launch_button')
      elsif coupon_book.incomplete?
        content_tag(:div, coupon_book.status, class:'btn btn-sm btn-danger disabled')
      else
        content_tag(:div, coupon_book.status, class:'btn btn-sm btn-success disabled')
      end
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

  def coupon_book_buy_button(coupon_book, button_color=:success)
    if coupon_book.launched?
      link_to 'Donate Now', donate_coupon_book_path(coupon_book), class: "btn btn-#{button_color} btn-xl buy_button"
    end
  end

  def category_load_button(category)
    link_to discounts_category_path(category), data:{toggle: 'remoteTab', target: "#pop-#{category.name.parameterize.underscore}"}, id:"tab-#{category.name.parameterize.underscore}", class:'book-nav-link' do
      content_tag(:span, category.name)
    end
  end

  def how_efg_works_link(text="How Eats for Good works!")
    content_tag(:a, data:{toggle: 'modal', target: '#how_it_works_modal'}) do
      content_tag(:span, nil, class:'glyphicon glyphicon-play-circle')+
      content_tag(:span, text)
    end
  end

  def share_on_fb_button(url, classes='')
    content_tag(:a, 'Share on Facebook', data:{url: url}, class: classes)
  end

  def join_mail_list
    content_tag(:a, 'Join our email list!', data:{toggle: 'modal', target: '#how_it_works_modal'})
  end

  def book_page_top_share
    content_tag(:div, nil, class:'addthis_custom_sharing')
  end

  def donate_top_link(coupon_book)
    if coupon_book.launched?
      content_tag(:a, "Donate", class: "btn-signup buy_button btn btn-success", data: {price: coupon_book.price_cents})
    end
  end

end