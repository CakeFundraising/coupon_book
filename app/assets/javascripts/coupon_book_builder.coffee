CakeCouponBook.coupon_books.build = (couponBookId)->
  #bookTree = CakeCouponBook.coupon_books.tree(couponBookId)
  #CakeCouponBook.coupon_books.tree = bookTree
  CakeCouponBook.coupon_books.dragging(couponBookId)
  return