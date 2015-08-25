CakeCouponBook.coupon_books ?= {}

CakeCouponBook.coupon_books.validation = ->
  $('.formtastic.coupon_book').validate(
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
      'coupon_book[name]': 
        required: true
      'coupon_book[title]': 
        required: true
      'coupon_book[organization_name]': 
        required: true
      'coupon_book[goal]':
        required: true
        minStrict: 0
        currency: ["$", false]
      'coupon_book[price]':
        required: true
        min: 1
        currency: ["$", false]
      'coupon_book[template]': 
        required: true
      'coupon_book[headline]':
        required: true
      'coupon_book[story]':
        required: true
      'coupon_book[url]':
        required: true
        url: true
      'coupon_book[main_cause]':
        required: true
      'coupon_book[picture_attributes][avatar]':
        required: true
      'coupon_book[picture_attributes][banner]':
        required: true
      # 'coupon_book[mission]':
      #   required: true
      # 'coupon_book[launch_date]':
      #   required: true
      # 'coupon_book[end_date]':
      #   required: true
  )
  return

visibility = ->
  containers = $('.visibility_buttons')
  links = containers.find('a')

  links.on("ajax:success", (e, data, status, xhr) ->
    current = $(this)
    opposite = current.siblings("a")

    opposite.removeClass "hidden"
    current.addClass "hidden"
    return
  ).on "ajax:error", (e, xhr, status, error) ->
    alert "There was an error when updating coupon_book, please reload this page and try again."
    return
  return

launch = ->
  buttons = $('.launch_button')
  launched_button = '<div class="btn btn-sm btn-success disabled">Launched</div>'

  buttons.on("ajax:success", (e, data, status, xhr) ->
    $(this).closest('.stat').prepend(launched_button)
    $(this).remove()
    return
  ).on "ajax:error", (e, xhr, status, error) ->
    alert "There was an error on launch, please reload this page and try again."
    return
  return

launch_template = ->
  button = $('a#launch-button')
  waitColumn = $('#wait-col')
  orColumn = $('#or-col')
  launchColumn = $('#launch-col')
  hiddenContent = $('#share-coupon-book')

  hiddenContent.hide()

  button.on("ajax:success", (e, data, status, xhr) ->
    hiddenContent.show()
    waitColumn.hide()
    orColumn.hide()
    launchColumn.removeClass('col-md-5').addClass('col-md-12')
    $(this).text('Successfully Launched!').attr("disabled","disabled")
    return
  ).on "ajax:error", (e, xhr, status, error) ->
    alert "There was an error on launch, please reload this page and try again."
    return
  return


CakeCouponBook.coupon_books.init = ->
  visibility()
  launch()
  launch_template()
  return
  