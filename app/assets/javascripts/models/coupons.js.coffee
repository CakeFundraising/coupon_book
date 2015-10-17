CakeCouponBook.coupons ?= {}

CakeCouponBook.coupons.validation = ->
  jQuery.validator.addClassRules
    coupon_merchandise_categories:
      required: true

  $('.formtastic.coupon').validate(
    ignore: ":hidden:not(.uri_input)"
    errorElement: "span"
    errorPlacement: (error, element)->
      error.appendTo(element.closest('.input'))
      return
    invalidHandler: (event, validator)->
      picsContainer = $('.uri_input')
      picsContainer.each ->
        input = $(this).closest('.input')
        input.removeClass('hidden')
        input.find('.form-label').hide()
        return
      return
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
      'coupon[picture_attributes][avatar]':
        required: true
  )
  return

CakeCouponBook.coupons.universal_toggle = (couponId)->
  url = "/deals/#{couponId}/universal_toggle"
  $.ajax
    url: url
    type: 'PATCH'
    
  return