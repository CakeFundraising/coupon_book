CakeCouponBook.collections ?= {}

CakeCouponBook.collections.switcher = ->
  existing_coupon_button = $('.buttons #add_universal_coupon')
  new_coupon_button = $('.buttons #create_new_coupon')

  tab1_button = $('#tab1_btn')
  tab2_button = $('#tab2_btn')

  existing_coupon_button.click (e)->
    tab1_button.click()
    $(this).addClass('btn-active')
    new_coupon_button.removeClass('btn-active')
    return

  new_coupon_button.click (e)->
    tab2_button.click()
    $(this).addClass('btn-active')
    existing_coupon_button.removeClass('btn-active')
    return

  return

CakeCouponBook.collections.initAddRemove = ->
  $('.coupons-container').find('.add_coupon_btn').each ->
    CakeCouponBook.collections.initAdd($(this))
    return
  $('.coupons-container').find('.remove_coupon_btn').each ->
    CakeCouponBook.collections.initRemove($(this))
    return
  return

CakeCouponBook.collections.initAdd = (element) ->
  element.one 'click', (e) ->
    $(this).removeClass('add_coupon_btn')
    $(this).addClass('remove_coupon_btn')
    $(this).find('.click_to_help').text('Remove from collection')

    thumbnail = $(this).closest('.thumbnail')

    thumbnail.removeClass('not-in-collection', 500, "easeInBack")
    thumbnail.addClass('in-collection')

    thumbnail.find('.label').removeClass('hidden', 500, 'linear')

    CakeCouponBook.collections.initRemove($(this))
    return
  return

CakeCouponBook.collections.initRemove = (element) ->
  element.one 'click', (e) ->
    $(this).removeClass('remove_coupon_btn')
    $(this).addClass('add_coupon_btn')
    $(this).find('.click_to_help').text('Add to collection')

    thumbnail = $(this).closest('.thumbnail')
    thumbnail.find('.label').addClass('hidden')

    thumbnail.removeClass('in-collection')
    thumbnail.addClass('not-in-collection', 500, "easeInBack")

    CakeCouponBook.collections.initAdd($(this))
    return
  return

CakeCouponBook.collections.addRemoveCoupons = ->

  return

# Init function
CakeCouponBook.collections.init = ->
  CakeCouponBook.collections.switcher()
  CakeCouponBook.collections.initAddRemove()
  return