window.CakeCouponBook ?= {}

CakeCouponBook.init = ->
  CakeCouponBook.datepicker()
  CakeCouponBook.validations.init()
  CakeCouponBook.crop.init()
  CakeCouponBook.coupon_categories.init()
  CakeCouponBook.utils.init()
  return

$(document).ready(CakeCouponBook.init)
$(document).on('page:load', CakeCouponBook.init)