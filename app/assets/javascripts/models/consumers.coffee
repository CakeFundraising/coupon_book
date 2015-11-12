CakeCouponBook.consumers ?= {}

CakeCouponBook.consumers.validation = ->
  $('.formtastic.consumer').validate(
    errorElement: "span"
    rules:
      'consumer[first_name]': 
        required: true
      'consumer[last_name]': 
        required: true
      'consumer[email]':
        required: true
        email: true
      'consumer[zip_code]':
        required: true
        minlength: 5
        maxlength: 5
  )
  return