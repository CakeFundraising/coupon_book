CakeCouponBook.coupon_books ?= {}
CakeCouponBook.coupon_books.templates ?= {}

CategoriesNav = require('./categories_nav.coffee');

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

initNav = ->
  new CategoriesNav().init()
  return

CakeCouponBook.coupon_books.templates.dealSeeAllLink = ->
  new CategoriesNav().dealSeeAll()
  return

CakeCouponBook.coupon_books.templates.compact = ->
  boxOverlay()
  afterPurchaseModal()
  backToTop()
  initNav()
  CakeCouponBook.subscriptors.validation()
  CakeCouponBook.consumers.validation()
  return