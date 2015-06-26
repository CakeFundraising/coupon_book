CakeCouponBook.coupon_books.organize = (couponBookId)->
  Organize = require('./react_components/coupon_books/Organize.js.jsx')

  new Organize(couponBookId).init()
  return
