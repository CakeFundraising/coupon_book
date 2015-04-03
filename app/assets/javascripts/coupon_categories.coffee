CakeCouponBook.coupon_categories ?= {}

CakeCouponBook.coupon_categories.reorder = ->
  $(".coupon_book").submit ->
#    console.log("Position: ");
    $("#categories > .ui-state-default").each ->
      position = $(this).index('.ui-state-default');
#      $(this).find("input").val(position);
      input_id = "#" + $(this).children('ul').attr('id') + "_position";
      $(input_id).val(position);
      console.log("Id: " + input_id);
      console.log("Position: " + position);
      return
    return
  return

CakeCouponBook.coupon_categories.init = ->
  $( "#coupon_categories__1, #coupon_categories__2, #coupon_categories__3" ).sortable({
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
  CakeCouponBook.coupon_categories.reorder();
  return