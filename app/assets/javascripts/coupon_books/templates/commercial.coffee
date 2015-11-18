CakeCouponBook.coupon_books ?= {}
CakeCouponBook.coupon_books.templates ?= {}

CategoriesNav = require('./categories.coffee');

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
  nav = new CategoriesNav()
  nav.seeAll()
  nav.dealSeeAll()
  return

CakeCouponBook.coupon_books.templates.commercial = ->
  boxOverlay()
  afterPurchaseModal()
  backToTop()
  categoriesNav()
  initNav()
  CakeCouponBook.subscriptors.validation()
  CakeCouponBook.consumers.validation()
  #CakeCouponBook.impressions.rendered(impression_id)
  return