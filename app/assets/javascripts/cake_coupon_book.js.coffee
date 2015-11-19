window.CakeCouponBook ?= {}

init = ->
  CakeCouponBook.datepicker()
  CakeCouponBook.clipboard()
  CakeCouponBook.expander()
  #CakeCouponBook.browsers.fingerprint()
  CakeCouponBook.validations.init()
  CakeCouponBook.utils.init()
  CakeCouponBook.coupon_books.init()
  CakeCouponBook.categories.init()
  CakeCouponBook.search.init()
  CakeCouponBook.overrides.init()
  CakeCouponBook.direct_donation.init()
  return

turboInit = ->
  CakeCouponBook.addThis.init()
  CakeCouponBook.parallax.init()
  return

$(document).ready(init)
$(document).on 'page:load', ->
  init()
  turboInit()
  return

$(document).on 'page:before-change', ->
  ZeroClipboard.destroy()
  return
