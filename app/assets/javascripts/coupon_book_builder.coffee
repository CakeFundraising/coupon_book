# React
React = require('react');
Canvas = require('./react_components/coupon_books/Canvas.js.jsx');

class Organize
  constructor: (couponBookId) ->
    @couponBookId = couponBookId
    @rootNode = $('#organize-react')[0]
    @sources = 
      couponBookId: couponBookId
      collectionCouponsSource: "/fundraisers/collection_coupons?cb_id=#{couponBookId}"
      collectionPrBoxesSource: "/fundraisers/collection_pr_boxes?cb_id=#{couponBookId}"
      categoriesSource: "/coupon_books/#{couponBookId}/categories"
    return

  init: ->
    React.render(React.createElement(Canvas, sources: @sources), @rootNode)
    return

CakeCouponBook.coupon_books.organize = (couponBookId)->
  new Organize(couponBookId).init()
  return
