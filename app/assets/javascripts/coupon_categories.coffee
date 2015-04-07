CakeCouponBook.coupon_categories ?= {}

CakeCouponBook.coupon_categories.saveCouponBookOrder = ->
  $(".coupon_book").submit ->
    CakeCouponBook.coupon_categories.saveCategoriesOrder();
  return

CakeCouponBook.coupon_categories.saveCategoriesOrder = ->
  $("#categories").find("ul").each ->
    category = $(this);
    category_position = category.parent().index();
    category_input_id = "#" + category.attr('id') + "_position";
    $(category_input_id).val(category_position);

    CakeCouponBook.coupon_categories.saveCouponsOrder(category);
    return
  return

CakeCouponBook.coupon_categories.saveCouponsOrder = (category) ->
  category_id = category.attr('id').replace(/\D/g, '');

  category.children(".ui-state-default").each ->
    coupon = $(this);
    coupon_position = coupon.index();
    coupon_input_id = "#" + coupon.attr('id') + "_position";
    coupon_category_input_id = "#" + coupon.attr('id') + "_coupon_category_id";
    $(coupon_input_id).val(coupon_position);
    $(coupon_category_input_id).val(category_id);
    return
  return

CakeCouponBook.coupon_categories.init = ->
  $( "#coupon_categories__1, #coupon_categories__2, #coupon_categories__3, #sponsor_coupons" ).sortable({
    items: "li:not(.ui-state-disabled)",
    connectWith: ".connectedSortable"
  }).disableSelection();

  $( "#categories" ).sortable({
    connectWith: ".connectedSortable2"
  }).disableSelection();

  CakeCouponBook.coupon_categories.saveCouponBookOrder();
  return