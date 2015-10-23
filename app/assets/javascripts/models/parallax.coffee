CakeCouponBook.parallax ?= {}

CakeCouponBook.parallax.init = ->
  console.log 'Hola desde Turbolinks!'
  $('.parallax-window').parallax()
  return