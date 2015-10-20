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

  aboutBanner = $('#learn-more-banner')

  nav.affix offset:
    top: 400

  nav.find('a.book-nav-link').each ->
    $(this).click ->
      $('html, body').animate { scrollTop: 300 }, 500
      return
    return

  return

scrollNav = ->
  nav = $('.book-nav ul.nav')
  buttons = nav.find('li a')

  buttons.each ->
    current = $(this)
    current.removeAttr('href').removeAttr('data-toggle')
    catId = current.data('cid')
    cat = $("##{catId}")

    current.off('click').click ->
      #Active
      nav.find('li').each ->
        $(this).removeClass('active')
        return
      current.closest('li').addClass('active')
      #Scroll
      $('html, body').animate { scrollTop: cat.offset().top - $('.book-nav').height() }, 500
      return
    return
  return

seeAll = ->
  loadTarget = $('#remote-items')
  dealLinks = loadTarget.find('.see-more-box')
  button = loadTarget.find('#see-more-link')
  spinner = loadTarget.find('#spinner')

  CakeCouponBook.coupon_books.templates.dealSeeAllLink()

  button.click ->
    spinner.removeClass('hidden')
    $(this).hide()
    return

  button.on("ajax:success", (e, data, status, xhr) ->
    loadTarget.html(data)
    CakeCouponBook.expander()
    scrollNav()
    return
  ).on "ajax:error", (e, xhr, status, error) ->
    spinner.hide()
    button.show()
    alert "There was an error, please reload this page and try again."
    return
  return

CakeCouponBook.coupon_books.templates.dealSeeAllLink = ->
  loadTarget = $('#remote-items')
  dealLinks = loadTarget.find('.see-more-box')
  button = loadTarget.find('#see-more-link')

  dealLinks.click ->
    button.click()
    return
  return

CakeCouponBook.coupon_books.templates.commercial = ->
  boxOverlay()
  afterPurchaseModal()
  backToTop()
  categoriesNav()
  seeAll()
  CakeCouponBook.subscriptors.validation()
  #CakeCouponBook.impressions.rendered(impression_id)
  return