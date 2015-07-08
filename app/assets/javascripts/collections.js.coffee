CakeCouponBook.collections ?= {}

switcher = ->
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

initAddRemove = ->
  containers = '.coupons-container, .pr-boxes-container'

  $(containers).find('.add_to_collection_btn').each ->
    initAdd($(this))
    return
  $(containers).find('.remove_from_collection_btn').each ->
    initRemove($(this))
    return
  return

initAdd = (coupon) ->
  coupon.one 'click', (e) ->
    coupon_id = $(this).attr('id')
    thumbnail = $(this).closest('.thumbnail')
    
    $(this).removeClass('add_to_collection_btn')
    $(this).addClass('remove_from_collection_btn')
    $(this).find('.click_to_help').text('Remove from collection')

    thumbnail.removeClass('not-in-collection', 500, "easeInBack").addClass('in-collection')
    thumbnail.find('.label').removeClass('hidden', 500, 'linear')
    
    createCollectionsCoupon(coupon_id)

    initRemove($(this))
    return
  return

initRemove = (coupon) ->
  coupon.one 'click', (e) ->
    coupon_id = $(this).attr('id')
    thumbnail = $(this).closest('.thumbnail')
    
    $(this).removeClass('remove_from_collection_btn')
    $(this).addClass('add_to_collection_btn')
    $(this).find('.click_to_help').text('Add to collection')

    thumbnail.removeClass('in-collection').addClass('not-in-collection', 500, "easeInBack")
    thumbnail.find('.label').addClass('hidden')
    
    deleteCollectionsCoupon(coupon_id)

    initAdd($(this))
    return
  return

createCollectionsCoupon = (coupon_id) ->
  $.ajax
    url: '/collections_coupons'
    type: 'POST'
    dataType: 'json'
    data:
      collections_coupon: { "coupon_id": coupon_id }
    success: (data, status, response) ->
      #todo
    error: ->
      #todo

  return

deleteCollectionsCoupon = (coupon_id) ->
  $.ajax
    url: "/collections_coupons/#{coupon_id}"
    type: 'DELETE'
    dataType: 'json'
    data:
      collections_coupon: { "coupon_id": coupon_id }
    success: (data, status, response) ->
      #todo
    error: ->
      #todo
  
  return

# Init function
CakeCouponBook.collections.init = ->
  switcher()
  initAddRemove()
  return