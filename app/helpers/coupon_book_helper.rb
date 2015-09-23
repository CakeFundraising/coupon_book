module CouponBookHelper
  def hidden_coupon_book_cancel_link
    link_to 'Cancel', @coupon_book, method: :delete, class:'hidden', id: 'hidden_delete_link'
  end

  def status_buttons(coupon_book)
    color = CouponBook::COLOR_STATUS[coupon_book.status.downcase]
    content_tag(:div, coupon_book.status, class:"btn btn-sm btn-#{color} disabled")
  end

  def screenshot_dowload(coupon_book)
    link_to "Download", 'http://res.cloudinary.com/cakefundraising/image/url2png/' + coupon_book_url(coupon_book), class:'btn btn-primary', download: 'deal_book.jpg'
  end

  def visibility_buttons(coupon_book)
    content_tag :div, class:'visibility_buttons' do
      content_tag :span do
        link_to("Hide", toggle_visibility_coupon_book_path(coupon_book), method: :patch, remote: true, class:"btn btn-danger btn-sm #{'hidden' unless coupon_book.visible}")+
        link_to("Show", toggle_visibility_coupon_book_path(coupon_book), method: :patch, remote: true, class:"btn btn-success btn-sm #{'hidden' if coupon_book.visible}")
      end
    end
  end

  def campaign_edit_button(campaign)
    if can? :edit, campaign and not campaign.past?
      link_to "Edit Campaign", edit_coupon_book_path(campaign), class:'btn btn-transparent-dark'
    end
  end

  def campaign_buy_button(campaign, text, url, color=:success)
    if campaign.launched?
      link_to text, url, class: "btn btn-#{color} btn-xl buy_button", data: {no_turbolink: true}
    end
  end

  def category_load_button(category)
    link_to discounts_category_path(category), data:{toggle: 'remoteTab', target: "#pop-#{category.name.parameterize.underscore}", callback:'CakeCouponBook.coupon_books.templates.dealSeeAllLink()', cid: category.id}, id:"tab-#{category.name.parameterize.underscore}", class:'book-nav-link' do
      content_tag(:span, category.name)
    end
  end

  def book_load_all_deals(book)
    content_tag(:span, class:'hidden', id:'spinner') do
      image_tag 'loading.gif'
    end +
    link_to('See All Deals', load_all_discounts_categories_path(coupon_book_id: book), remote: true, class:'btn btn-default btn-lg', id:'see-more-link')
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
    link_to 'Join our email list!', efg_contact_path, target: :_blank
  end

  def book_page_top_share
    content_tag(:div, nil, class:'addthis_custom_sharing')
  end

  def flag_book_link
    link_to efg_contact_path, target: :_blank do
      content_tag(:span, nil, class:'glyphicon glyphicon-flag')+
      content_tag(:span, ' Flag')
    end
  end

end