CakeCouponBook.coupons ?= {}

CakeCouponBook.coupons.validation = ->
  $('.formtastic.coupon').validate(
    errorElement: "span"
    rules:
      'coupon[phone]': 
        required: true
      'coupon[location_attributes][address]': 
        required: true
      'coupon[location_attributes][city]': 
        required: true
      'coupon[location_attributes][zip_code]': 
        required: true
      'coupon[location_attributes][state_code]': 
        required: true
      'coupon[sponsor_url]': 
        required: true
        url: true
      'coupon[multiple_locations]': 
        required: true
      'coupon[terms]': 
        required: true
  )
  return