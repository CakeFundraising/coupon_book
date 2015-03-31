window.CakeCouponBook ?= {}

CakeCouponBook.init = ->
  CakeCouponBook.datepicker()
  CakeCouponBook.validations.init()
  CakeCouponBook.coupon_categories.init()
  return

$(document).ready(CakeCouponBook.init)
$(document).on('page:load', CakeCouponBook.init)