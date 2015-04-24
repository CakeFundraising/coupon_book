module CouponBookHelper
  def hidden_coupon_book_cancel_link
    link_to 'Cancel', @coupon_book, method: :delete, class:'hidden', id: 'hidden_delete_link'
  end
end