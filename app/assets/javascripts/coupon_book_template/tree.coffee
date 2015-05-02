class Coupon
  constructor: (@coupon) ->
    @id = @coupon['id']
    @title = @coupon['title']
    @position = @coupon['position']
    return 
  
class Category
  constructor: (@category) ->
    @parse()
    return this
  
  parse: ->
    @id = @category['id']
    @name = @category['name']
    @position = @category['position']

    coupons = @category['coupons']
    @coupons = (new Coupon(coupon) for coupon in coupons)
    return

class BookTree
  constructor: (@book_id) ->
    @tree = {}
    @init()
    return

  init: ->
    @loadTree()
    return

  loadTree: ->
    loadPath = "/coupon_books/#{@book_id}/tree"
    self = this

    $.get loadPath, (data) ->
      self.tree = self.parse(data)
      return
    return

  getTree: ->
    return @tree

  parse: (jsonData)->
    categories = jsonData['root']
    @categories = (new Category(category) for category in categories)
    return @categories

  updateCategory: ->
    return


CakeCouponBook.coupon_books.tree = (couponBookId)->
  return new BookTree(couponBookId)

