CakeCouponBook.coupon_books ?= {}
CakeCouponBook.coupon_books.templates ?= {}

toggleNav = ->
  nav = $('nav.navbar.navbar-default')
  if nav.find('.logged-out').length isnt 0
    nav.hide()
  return

boxOverlay = ->
  $(".overlay-img").mouseenter(->
    $(this).addClass "hover"
    return
  ).mouseleave -> # handle the mouseleave functionality
    $(this).removeClass "hover"
    return
  return

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

afterPurchaseModal = ->
  $('#after_purchase_modal').modal('show') if window.location.search.indexOf("purchased=1") > -1
  return

backToTop = ->
  if ($(window).height() + 1200) < $(document).height()
    $('#top-link-block').removeClass('hidden').affix offset: top: 1200
  return

categoriesNav = ->
  nav = $('.book-nav')
  navSection = nav.find('.nav-section')
  buttonSection = nav.find('.buy_button_section')
  navAboutLink = nav.find('.nav-about-link')

  aboutBanner = $('#learn-more-banner')
  documentWidth = $(document).width()

  buttonSection.hide()

  nav.affix offset:
    top: nav.offset().top

  nav.on 'affixed.bs.affix', ->
    nav.css('width', documentWidth)
    navSection.removeClass('col-md-12').addClass('col-md-10')
    buttonSection.show()
    return

  nav.on 'affix-top.bs.affix', ->
    buttonSection.hide()
    navSection.removeClass('col-md-10').addClass('col-md-12')
    return

  nav.find('a.book-nav-link').each ->
    $(this).click ->
      $('html, body').animate { scrollTop: $('#coupons.green').offset().top }, 500
      return
    return

  navAboutLink.click ->
    $('html, body').animate { scrollTop: aboutBanner.offset().top - $('.book-nav').height() }, 500
    return
  return

CakeCouponBook.coupon_books.templates.original = (end_date, impression_id)->
  toggleNav()
  boxOverlay()
  countdown(end_date)
  afterPurchaseModal()
  backToTop()
  categoriesNav()
  CakeCouponBook.subscriptors.validation()
  #CakeCouponBook.impressions.rendered(impression_id)
  return