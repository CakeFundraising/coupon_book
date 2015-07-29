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

##### Coupon Book Show ########
CakeCouponBook.coupon_books.show = (end_date, impression_id, campaignId)->
  toggleNav()
  mini_pledges()
  countdown(end_date)
  showBuyButton()
  afterPurchaseModal()
  backToTop()
  CakeCouponBook.subscriptors.validation()
  categoriesNavAffix()
  #CakeCouponBook.impressions.rendered(impression_id)
  #Cake.pusher.coupon_books.updateRaised(campaignId) if campaignId
  return

categoriesNavAffix = ->
  nav = $('.book-nav')
  aboutBanner = $('#learn-more-banner')
  
  $(window).scroll ->
    navOffset = nav.offset().top
    bannerPosition = aboutBanner.position().top
    navHeight = nav.height()

    if (navOffset + navHeight) > bannerPosition
      nav.removeClass('affix').addClass('affix-top') 
      $('html, body').scrollTop(bannerPosition + 60)
    return

  nav.affix offset:
    top: nav.offset().top

  nav.find('a.book-nav-link').each ->
    $(this).click ->
      $('html, body').animate { scrollTop: $('#coupons.green').offset().top }, 500
      return
    return
  return

afterPurchaseModal = ->
  $('#after_purchase_modal').modal('show') if window.location.search.includes('purchased=1')
  return

showBuyButton = ->
  button = $('.floating-right a.buy_button')

  $(document).scroll ->
    y = $(this).scrollTop()
    if y > 800
      button.fadeIn()
    else
      button.fadeOut()
    return
  return

backToTop = ->
  if ( ($(window).height() + 1200) < $(document).height() )
    $('#top-link-block').removeClass('hidden').affix({
      offset: {top:1200}
    });
  return

#Campaign Show Functions
countdown = (end_date) ->
  # There is a timezone issue that needs to be resolved
  # At least now the date is showing up on the iphone, although it is one day off.
  arr = end_date.split(/[- :]/)
  end_date = new Date(arr[0], arr[1] - 1, arr[2], arr[3], arr[4], arr[5])
  
  $("#campaign_countdown").countdown end_date, (event) ->
    countdown_section = $(this)
    # days
    countdown_section.find("span.campaign-timer.days").html event.strftime("%-D")
    # hours
    countdown_section.find("span.campaign-timer.hours").html event.strftime("%H")
    # minutes
    countdown_section.find("span.campaign-timer.mins").html event.strftime("%M")
    return
  return

mini_pledges = ->
  if Modernizr.touch
    # show the close overlay button
    $(".close-overlay").removeClass "hidden"
    # handle the adding of hover class when clicked
    $(".overlay-img").click (e) ->
      $(this).addClass "hover"  unless $(this).hasClass("hover")
      return
    # handle the closing of the overlay
    $(".close-overlay").click (e) ->
      e.preventDefault()
      e.stopPropagation()
      $(this).closest(".overlay-img").removeClass "hover" if $(this).closest(".overlay-img").hasClass("hover")
      return
  else
    # handle the mouseenter functionality
    $(".overlay-img").mouseenter(->
      $(this).addClass "hover"
      return
    ).mouseleave -> # handle the mouseleave functionality
      $(this).removeClass "hover"
      return
  return

toggleNav = ->
  nav = $('nav.navbar.navbar-default')

  if nav.find('.logged-out').length isnt 0
    expandLogo = $('.expand-nav-logo')

    nav.hide()
    # expandLogo.click ->
    #   nav.fadeIn 500
    #   $(this).hide()
    #   return
  return
  