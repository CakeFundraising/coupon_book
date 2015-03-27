window.CakeCouponBook ?= {}

CakeCouponBook.init = ->
  CakeCouponBook.datepicker()
  CakeCouponBook.validations.init()
  return

$(document).ready(CakeCouponBook.init)
$(document).on('page:load', CakeCouponBook.init)