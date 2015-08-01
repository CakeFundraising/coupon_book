toggleNav = ->
  nav = $('nav.navbar.navbar-default')

  if nav.find('.logged-out').length isnt 0
    nav.hide()
  return

showBuyButton = ->
  button = $('.floating-right a.buy_button')

  $(document).scroll ->
    y = $(this).scrollTop()
    if y > 400
      button.fadeIn()
    else
      button.fadeOut()
    return
  return

seeMore = ->
  loadTarget = $('#remote-items')
  button = loadTarget.find('#see-more-link')
  spinner = loadTarget.find('#spinner')

  button.click ->
    spinner.removeClass('hidden')
    $(this).hide()
    return

  button.on("ajax:success", (e, data, status, xhr) ->
    loadTarget.html(data)
    return
  ).on "ajax:error", (e, xhr, status, error) ->
    spinner.hide()
    button.show()
    alert "There was an error, please reload this page and try again."
    return
  return

CakeCouponBook.coupon_books.mobileShow = ->
  toggleNav()
  CakeCouponBook.subscriptors.validation()
  showBuyButton()
  seeMore()
  return