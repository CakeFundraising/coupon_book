CakeCouponBook.coupon_books ?= {}
CakeCouponBook.coupon_books.templates ?= {}

boxOverlay = ->
  $(".overlay-img").mouseenter(->
    $(this).addClass "hover"
    return
  ).mouseleave -> # handle the mouseleave functionality
    $(this).removeClass "hover"
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

  nav.affix offset:
    top: nav.offset().top

  nav.find('a.book-nav-link').each ->
    $(this).click ->
      $('html, body').animate { scrollTop: 0 }, 500
      return
    return

  navAboutLink.click ->
    $('html, body').animate { scrollTop: aboutBanner.offset().top - $('.book-nav').height() }, 500
    return
  return

CakeCouponBook.coupon_books.templates.compact = ->
  boxOverlay()
  afterPurchaseModal()
  backToTop()
  categoriesNav()
  CakeCouponBook.subscriptors.validation()
  #CakeCouponBook.impressions.rendered(impression_id)
  return