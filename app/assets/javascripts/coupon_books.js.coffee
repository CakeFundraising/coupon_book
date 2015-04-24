CakeCouponBook.coupon_books ?= {}

CakeCouponBook.coupon_books.getCouponCollection = ->
  my_coupons = []

  $("#my_coupons").children(".ui-state-default").each ->
    my_coupons.push($(this))
    return
  return my_coupons

CakeCouponBook.coupon_books.getCategories = ->
  categories = $("#categories").find("ul.sortableCoupons")

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
    category_input_id = "#" + category.attr('id').replace(/coupon_/, "") + "_position"
    $(category_input_id).val(category_position)
    CakeCouponBook.coupon_books.saveCouponsOrder(category)
    return
  return

CakeCouponBook.coupon_books.saveCouponsOrder = (category) ->
  category_id = category.attr('id').replace(/\D/g, '')

  category.children(".ui-state-default").each ->
    coupon = $(this)
    coupon_position = coupon.index()
    position_input_id = $(this).find('.position-input').find('input')
    category_input_id = $(this).find('.category_id-input').find('input')
    position_input_id.val(coupon_position)
    category_input_id.val(category_id)
    return
  return

CakeCouponBook.coupon_books.greyOutUsedCoupons = (categories) ->
  $(categories).find(".ui-state-default").each ->
    coupon = $("#my_coupons").find("." + $(this).attr('class').split(' ')[1])
    coupon.addClass('in-book')

CakeCouponBook.coupon_books.removeFromBook = ->
  $(".remove-from-book").click ->
    coupon_id = $(this).attr('id').replace(/\D/g, '')
    $("#categories").find(".coupons__" + coupon_id).remove()
    $("#my_coupons").find(".coupons__" + coupon_id).removeClass('in-book')
  return

CakeCouponBook.coupon_books.getCouponClass = (coupon) ->
  $(coupon).attr('class').split(' ')[1]

CakeCouponBook.coupon_books.initDragAndDrop = (my_coupons, categories) ->

  $( categories ).sortable({
    items: "li:not(.ui-state-disabled)",
    connectWith: ".sortableCoupons",
    stop: (event, ui) ->
      $(this).find(".remove-from-book").click ->
        coupon_id = $(this).attr('id').replace(/\D/g, '')
        $("#categories").find(".coupons__" + coupon_id).remove()
        $("#my_coupons").find(".coupons__" + coupon_id).removeClass('in-book')

  }).disableSelection()

  $( my_coupons ).draggable({
    connectToSortable: ".sortableCoupons",
    revert: "invalid",
    cancel: ".in-book",
    helper: (event) ->
      original = if $(event.target).hasClass("ui-draggable") then $(event.target) else $(event.target).closest(".ui-draggable")
      original.clone().css({ width: original.width() })
    ,
    start: (event, ui) ->
      ui.helper.find("input").each ->
        collection_id = $(this).attr('id')
        collection_name = $(this).attr('name')
        category_id = collection_id.replace(/collections/g, "categories")
        category_name = collection_name.replace(/collections/g, "categories")
        category_id = category_id.replace(/collection/g, "category")
        category_name = category_name.replace(/collection/g, "category")
        $(this).attr("id", category_id)
        $(this).attr('name', category_name)

      coupon_class = $(this).attr('class').split(' ')[1]
      $(this).addClass('in-book')

      ui.helper.on("remove", ->
        coupon_class = $(this).attr('class').split(' ')[1]
        $("#my_coupons").find("." + coupon_class).removeClass("in-book")
      )
    ,
    stop: (event, ui) ->
      coupon_class = $(this).attr('class').split(' ')[1]
      $("#my_coupons").find("." + coupon_class).removeClass("in-book") if $("#categories").find("." + coupon_class).length == 0


  }).disableSelection()

  $( "#categories" ).sortable({
    connectWith: ".sortableCategories"
  }).disableSelection()
  return

CakeCouponBook.coupon_books.init = ->

  my_coupons = CakeCouponBook.coupon_books.getCouponCollection()
  categories = CakeCouponBook.coupon_books.getCategories()

  CakeCouponBook.coupon_books.greyOutUsedCoupons(categories)
  CakeCouponBook.coupon_books.initDragAndDrop(my_coupons, categories)
  CakeCouponBook.coupon_books.removeFromBook()

  CakeCouponBook.coupon_books.saveCouponBookOrder()
  CakeCouponBook.coupon_books.spCouponsRowMatchHeight()
  return