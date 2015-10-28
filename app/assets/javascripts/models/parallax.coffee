CakeCouponBook.parallax ?= {}

CakeCouponBook.parallax.init = ->
  $('.parallax-window').parallax(
    naturalWidth: 1440,
    naturalHeight: 900,
    bleed: 60
  )
  return