CakeCouponBook.coupons ?= {}

CakeCouponBook.coupons.validation = ->
  jQuery.validator.addClassRules
    coupon_merchandise_categories:
      required: true

  $('.formtastic.coupon').validate(
    ignore: []
    errorElement: "span"
    rules:
      'coupon[sponsor_name]': 
        required: true
      'coupon[phone]': 
        required: true
      'coupon[sponsor_url]': 
        required: true
        url: true
      'coupon[location_attributes][address]': 
        required: true
      'coupon[location_attributes][city]': 
        required: true
      'coupon[location_attributes][zip_code]': 
        required: true
      'coupon[location_attributes][state_code]': 
        required: true
      'coupon[terms]': 
        required: true
      'coupon[title]': 
        required: true
      'coupon[expires_at]': 
        required: true
      'coupon[description]': 
        required: true
      'coupon[url]': 
        required: true
        url: true
      'coupon[price]': 
        required: true
        minStrict: 1
      'coupon[avatar_picture_attributes][uri]':
        required: true
  )
  return

CakeCouponBook.coupons.universal_toggle = (couponId)->
  url = "/coupons/#{couponId}/universal_toggle"
  $.ajax
    url: url
    type: 'PATCH'
    
  return