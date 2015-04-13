CakeCouponBook.coupon_books ?= {}

CakeCouponBook.coupon_books.getCouponCollection = ->
  my_coupons = []

  $("#my_coupons").children(".ui-state-default").each ->
    my_coupons.push($(this))
    return
  return my_coupons

CakeCouponBook.coupon_books.getCategories = ->
  categories = []
#  categories.push($("#my_coupons"))

  $("#categories").find("ul.sortableCoupons").each ->
    categories.push($(this))
    return
  return categories

CakeCouponBook.coupon_books.spCouponsRowMatchHeight = ->
  row_height = $("#categories").find('tr').height()
  $("#my_coupons").find('tr').height(row_height)
  return

CakeCouponBook.coupon_books.saveCouponBookOrder = ->
  $(".coupon_book").submit ->
    CakeCouponBook.coupon_books.saveCategoriesOrder()
  return

CakeCouponBook.coupon_books.saveCategoriesOrder = ->
  $("#categories").find("ul").each ->
    category = $(this)
    category_position = category.parent().index()
    category_input_id = "#" + category.attr('id') + "_position"
    $(category_input_id).val(category_position)
    CakeCouponBook.coupon_books.saveCouponsOrder(category)
    return
  return

CakeCouponBook.coupon_books.saveCouponsOrder = (category) ->
  category_id = category.attr('id').replace(/\D/g, '')

  category.children(".ui-state-default").each ->
    coupon = $(this)
    coupon_position = coupon.index()
    coupon_input_id = "#" + coupon.attr('class').split(' ')[1] + "_position"
    coupon_category_input_id = "#" + coupon.attr('class').split(' ')[1] + "_coupon_category_id"
    console.log(coupon_input_id + ": " + coupon_position)
    $(category).find(coupon_input_id).val(coupon_position)
    $(category).find(coupon_category_input_id).val(category_id)
    return
  return

CakeCouponBook.coupon_books.init = ->

  my_coupons = CakeCouponBook.coupon_books.getCouponCollection()
  categories = CakeCouponBook.coupon_books.getCategories()

  $( categories ).sortable({
    items: "li:not(.ui-state-disabled)",
    connectWith: ".sortableCoupons"
  }).disableSelection()

  $( my_coupons ).draggable({
    connectToSortable: ".sortableCoupons",
    revert: "invalid",
    helper: (event) ->
      original = if $(event.target).hasClass("ui-draggable") then $(event.target) else $(event.target).closest(".ui-draggable")
      original.clone().css({ width: original.width() })
    ,
    start: (event, ui) ->
      coupon_class = $(this).attr('class').split(' ')[1]
      console.log(coupon_class)
      ui.helper.remove() if $("#categories").find("." + coupon_class).length == 1
  }).disableSelection()

  $( "#categories" ).sortable({
    connectWith: ".sortableCategories"
  }).disableSelection()

  CakeCouponBook.coupon_books.saveCouponBookOrder()
  CakeCouponBook.coupon_books.spCouponsRowMatchHeight()
  return