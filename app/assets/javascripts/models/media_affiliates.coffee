CakeCouponBook.media_affiliates ?= {}

CakeCouponBook.media_affiliates.validation = ->
  $('.formtastic.media_affiliate').validate(
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
      'media_affiliate[avatar_picture_attributes][uri]':
        required: true
      'media_affiliate[first_name]': 
        required: true
      'media_affiliate[last_name]': 
        required: true
      'media_affiliate[email]': 
        required: true
      'media_affiliate[phone]':
        required: true
        phoneUS: true
      'media_affiliate[url]':
        required: true
        url: true
      'media_affiliate[location_attributes][address]': 
        required: true
      'media_affiliate[location_attributes][city]': 
        required: true
      'media_affiliate[location_attributes][zip_code]': 
        required: true
      'media_affiliate[location_attributes][state_code]': 
        required: true
  )
  return