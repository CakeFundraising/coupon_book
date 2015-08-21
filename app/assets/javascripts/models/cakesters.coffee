CakeCouponBook.cakesters ?= {}

CakeCouponBook.cakesters.validation = ->
  $('.formtastic.cakester').validate(
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
      'cakester[avatar_picture_attributes][uri]':
        required: true
      'cakester[phone]':
        required: true
        phoneUS: true
      'cakester[location_attributes][address]': 
        required: true
      'cakester[location_attributes][city]': 
        required: true
      'cakester[location_attributes][zip_code]': 
        required: true
      'cakester[location_attributes][state_code]': 
        required: true
  )
  return