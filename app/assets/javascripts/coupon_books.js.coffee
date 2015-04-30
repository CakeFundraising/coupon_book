CakeCouponBook.coupon_books ?= {}

CakeCouponBook.coupon_books.validation = ->
  $('.formtastic.coupon_book').validate(
    errorElement: "span"
    rules:
      'coupon_book[name]': 
        required: true
      'coupon_book[goal]':
        required: true
        currency: ["$", false]
      'coupon_book[launch_date]':
        required: true
      'coupon_book[end_date]':
        required: true
      'coupon_book[mission]':
        required: true
      'coupon_book[headline]':
        required: true
      'coupon_book[story]':
        required: true
      'coupon_book[goal]':
        required: true
        minStrict: 0
      'coupon_book[url]':
        required: true
        url: true
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
    alert "There were an error when updating coupon_book, please reload this page and try again."
    return
  return

launch = ->
  buttons = $('.launch_button')
  launched_button = '<div class="btn btn-sm btn-success disabled">Launched</div>'

  buttons.on("ajax:success", (e, data, status, xhr) ->
    current = $(this)
    current.closest('td').html(launched_button)
    return
  ).on "ajax:error", (e, xhr, status, error) ->
    alert "There were an error when updating coupon_book, please reload this page and try again."
    return
  return

CakeCouponBook.coupon_books.init = ->
  visibility()
  launch()
  return