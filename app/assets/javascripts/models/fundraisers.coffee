CakeCouponBook.fundraisers ?= {}

CakeCouponBook.fundraisers.validation = ->
  $('.formtastic.fundraiser').validate(
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
      'fundraiser[first_name]': 
        required: true
      'fundraiser[last_name]': 
        required: true
      'fundraiser[email]': 
        required: true
      'fundraiser[avatar_picture_attributes][uri]':
        required: true
      'fundraiser[phone]':
        required: true
        phoneUS: true
      'fundraiser[url]':
        required: true
        url: true
      'fundraiser[location_attributes][address]': 
        required: true
      'fundraiser[location_attributes][city]': 
        required: true
      'fundraiser[location_attributes][zip_code]': 
        required: true
      'fundraiser[location_attributes][state_code]': 
        required: true
  )
  return