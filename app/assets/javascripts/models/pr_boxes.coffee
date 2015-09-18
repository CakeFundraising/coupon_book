CakeCouponBook.pr_boxes ?= {}

CakeCouponBook.pr_boxes.validation = ->
  $('.formtastic.pr_box').validate(
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
      'pr_box[sponsor_name]':
        required: true
      'pr_box[title]':
        required: true
      'pr_box[description]':
        required: true
      'pr_box[url]':
        required: true
      'pr_box[flag]':
        required: true
      'pr_box[picture_attributes][avatar]':
        required: true

  )
  return