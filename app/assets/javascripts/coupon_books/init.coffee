window.CakeCouponBook ?= {}

init = ->
  CakeCouponBook.expander()
  CakeCouponBook.browsers.fingerprint()
  CakeCouponBook.utils.init()
  #CakeCouponBook.direct_donation.init()
  return

turboInit = ->
  CakeCouponBook.addThis.init()
  return

$(document).ready(init)

$(document).on 'page:load', ->
  init()
  turboInit()
  return
