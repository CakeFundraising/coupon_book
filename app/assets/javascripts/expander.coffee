CakeCouponBook.expander = ->
  $('.expander').expander
    slicePoint: 500
    widow: 4
    expandEffect: "show"
    userCollapseText: "Close"

  $('.expander-250').expander
    slicePoint: 250
    widow: 4
    expandEffect: "show"
    userCollapseText: "Close"

  $('.expander-150').expander
    slicePoint: 150
    widow: 4
    expandEffect: "show"
    userCollapseText: "Close"
  return