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
      'coupon[title]': 
        required: true
      'coupon[expires_at]': 
        required: true
      'coupon[promo_code]': 
        required: true
      'coupon[description]': 
        required: true
      'coupon[url]': 
        required: true
        url: true
      'coupon[price]': 
        required: true
      'coupon[merchandise_categories][]': 
        required: true
  )
  return