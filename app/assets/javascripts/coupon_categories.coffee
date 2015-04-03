CakeCouponBook.coupon_categories ?= {}

CakeCouponBook.coupon_categories.reorder = ->
  $(".coupon_book").submit ->
    $(".connectedSortable").children().each ->
      position = $(this).index();
      $(this).parent().find("input").val(position);
      return
    return
  return

CakeCouponBook.coupon_categories.init = ->
  $( "#coupons_1, #coupons_2, #coupons_3" ).sortable({
    connectWith: ".connectedSortable"
  }).disableSelection();
  CakeCouponBook.coupon_categories.reorder();
  return