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
    items: "li:not(.ui-state-disabled)",
    connectWith: ".connectedSortable"
  }).disableSelection();
  $( "#categories" ).sortable({
#    items: "a:not(.btn)",
    connectWith: ".connectedSortable2"
  }).disableSelection();
#  $( "ul a" ).sortable({
#    disabled: true
#  });
#  CakeCouponBook.coupon_categories.reorder();
  return