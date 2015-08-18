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

  buttonSection.hide()

  nav.affix offset:
    top: nav.offset().top

  nav.on 'affixed.bs.affix', ->
    navSection.removeClass('col-md-12').addClass('col-md-9')
    buttonSection.show()
    return

  nav.on 'affix-top.bs.affix', ->
    buttonSection.hide()
    navSection.removeClass('col-md-9').addClass('col-md-12')
    return

  nav.find('a.book-nav-link').each ->
    $(this).click ->
      $('html, body').animate { scrollTop: $('#coupons.green').offset().top }, 500
      return
    return
  return

scrollNav = ->
  nav = $('.book-nav ul.nav')
  buttons = nav.find('li a.book-nav-link')

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
  button = loadTarget.find('#see-more-link')
  spinner = loadTarget.find('#spinner')

  button.click ->
    spinner.removeClass('hidden')
    $(this).hide()
    return

  button.on("ajax:success", (e, data, status, xhr) ->
    loadTarget.html(data)
    scrollNav()
    return
  ).on "ajax:error", (e, xhr, status, error) ->
    spinner.hide()
    button.show()
    alert "There was an error, please reload this page and try again."
    return
  return

CakeCouponBook.coupon_books.templates.compact = ->
  boxOverlay()
  afterPurchaseModal()
  backToTop()
  categoriesNav()
  seeAll()
  CakeCouponBook.subscriptors.validation()
  #CakeCouponBook.impressions.rendered(impression_id)
  return