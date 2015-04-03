CakeCouponBook.coupon_categories ?= {}

CakeCouponBook.coupon_categories.reorder = ->
  $(".coupon_book").submit ->
    $("ul li").each ->
      position = $(this).index();
      $(this).find("input").val(position);
      return
    return
  return

CakeCouponBook.coupon_categories.init = ->
  $( "#coupons_1, #coupons_2, #coupons_3" ).sortable({
    connectWith: ".connectedSortable"
  }).disableSelection();
  $( "#category_1, #category_2, #category_3" ).sortable({
    connectWith: ".connectedSortable2"
  }).disableSelection();
#  CakeCouponBook.coupon_categories.reorder();
  return