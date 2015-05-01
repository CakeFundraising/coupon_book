CakeCouponBook.collections ?= {}

CakeCouponBook.collections.switcher = ->
  existing_coupon_button = $('.buttons #add_existing_coupon')
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

# Init function
CakeCouponBook.collections.init = ->
  CakeCouponBook.collections.switcher()
  return