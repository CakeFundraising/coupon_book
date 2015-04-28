CakeCouponBook.categories ?= {}

validation = ->
  $('.formtastic.category').validate(
    errorElement: "span"
    rules:
      'category[name]':
        required: true
  )
  return

CakeCouponBook.categories.init = ->
  validation()
  return