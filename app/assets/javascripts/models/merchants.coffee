CakeCouponBook.merchants ?= {}

CakeCouponBook.merchants.validation = ->
  $('.formtastic.merchant').validate(
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
      'merchant[avatar_picture_attributes][uri]':
        required: true
      'merchant[first_name]': 
        required: true
      'merchant[last_name]': 
        required: true
      'merchant[organization_name]':
        required: true
      'merchant[email]': 
        required: true
      'merchant[phone]':
        required: true
        phoneUS: true
      'merchant[url]':
        required: true
        url: true
      'merchant[location_attributes][address]': 
        required: true
      'merchant[location_attributes][city]': 
        required: true
      'merchant[location_attributes][zip_code]': 
        required: true
        minlength: 5
        maxlength: 5
      'merchant[location_attributes][state_code]': 
        required: true
  )
  return