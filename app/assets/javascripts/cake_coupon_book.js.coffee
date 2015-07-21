window.CakeCouponBook ?= {}

CakeCouponBook.init = ->
  CakeCouponBook.datepicker()
  CakeCouponBook.clipboard()
  CakeCouponBook.expander()
  CakeCouponBook.browsers.fingerprint()
  CakeCouponBook.addThis.init()
  CakeCouponBook.validations.init()
  CakeCouponBook.utils.init()
  CakeCouponBook.coupon_books.init()
  CakeCouponBook.categories.init()
  CakeCouponBook.search.init()
  CakeCouponBook.overrides.init()
  CakeCouponBook.direct_donation.init()
  return

$(document).ready(CakeCouponBook.init)
$(document).on('page:load', CakeCouponBook.init)

$(document).on 'page:before-change', ->
  ZeroClipboard.destroy()
  return