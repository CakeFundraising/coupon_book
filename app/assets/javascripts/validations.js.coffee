CakeCouponBook.validations ?= {}

CakeCouponBook.validations.init = ->
  CakeCouponBook.coupons.validation()
  return