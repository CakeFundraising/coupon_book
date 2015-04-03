CakeCouponBook.coupon_categories ?= {}

CakeCouponBook.coupon_categories.reorder = ->
  $(".coupon_book").submit ->
    row_num = 0;
    $(".connectedSortable").children(".ui-state-default").each ->
      row_num++;
      $(this).parent().find("input").val(row_num);
      return
    return
  return

CakeCouponBook.coupon_categories.init = ->
  $( "#category_1_container, #category_2_container, #category_3_container" ).sortable({
    connectWith: ".connectedSortable"
  }).disableSelection();
  CakeCouponBook.coupon_categories.reorder();
  return