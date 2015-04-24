window.CakeCouponBook ?= {}

CakeCouponBook.init = ->
  CakeCouponBook.datepicker()
  CakeCouponBook.validations.init()
  CakeCouponBook.crop.init()
  CakeCouponBook.utils.init()
  CakeCouponBook.coupon_books.init()
  return

$(document).ready(CakeCouponBook.init)
$(document).on('page:load', CakeCouponBook.init)