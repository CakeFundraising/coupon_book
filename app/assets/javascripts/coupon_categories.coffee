CakeCouponBook.coupon_categories ?= {}

CakeCouponBook.coupon_categories.reorder = ->
  $(".coupon_book").submit ->
    $("tbody tr").each ->
      row = $(this).index() + 1;
      $(this).find("input").val(row);
      return
    return
  return

CakeCouponBook.coupon_categories.init = ->
  $("#coupon_categories_table").tableDnD();
  CakeCouponBook.coupon_categories.reorder();
  return