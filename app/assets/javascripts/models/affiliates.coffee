CakeCouponBook.affiliates ?= {}

CakeCouponBook.affiliates.validation = ->
  $('.formtastic.affiliate').validate(
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
      'affiliate[avatar_picture_attributes][uri]':
        required: true
      'affiliate[phone]':
        required: true
        phoneUS: true
      'affiliate[location_attributes][address]': 
        required: true
      'affiliate[location_attributes][city]': 
        required: true
      'affiliate[location_attributes][zip_code]': 
        required: true
      'affiliate[location_attributes][state_code]': 
        required: true
  )
  return