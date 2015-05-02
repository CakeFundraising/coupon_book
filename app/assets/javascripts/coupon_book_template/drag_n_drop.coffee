class CollectionCoupon
  constructor: (@coupon) ->
    return

  showInCollection: ->
    @coupon.removeClass('in-book')
    return

class CategorizedCoupon
  constructor: (@coupon, @tree) ->
    @originalCopy = new CollectionCoupon($("#collection-coupons li.collection-coupon##{@coupon.attr('id')}"))
    @removeLink = @coupon.find('a.remove-from-book')
    @init()
    return

  init: ->
    @removeDestroyAttrs()
    @setUpRemoveFromCategoryLink()
    @replaceTrashIcon()
    return

  removeDestroyAttrs: ->
    @removeLink.removeAttr('data-confirm')
    @removeLink.removeAttr('data-method')
    @removeLink.removeAttr('href')
    return

  setUpRemoveFromCategoryLink: ->
    self = this
    @removeLink.click ->
      self.destroy()
      return
    return

  replaceTrashIcon: ->
    @removeLink.find('span').removeClass('glyphicon-trash').addClass('glyphicon-remove')
    return

  update: ->
    console.log 'Setear category'
    console.log @tree
    return

  destroy: ->
    @coupon.remove()
    @originalCopy.showInCollection()
    return


class CouponBook
  constructor: (@couponBookId)->
    @submit = $('#submit')

    @collection = $("#collection-coupons")
    @collectionCoupons = @collection.find("li.collection-coupon")
    @categoriesContainer = $("#categories")
    @categoriesWrappers = @categoriesContainer.find("ul.sortableCoupons")
    @categories = @categoriesContainer.find('li.category')

    @tree = {}

    @init()
    return

  init: ->
    @sortCategories()
    @draggableCoupons()
    @listenToSubmit()
    return

  listenToSubmit: ->
    self = this
    @submit.click ->
      self.submitTree()
      return
    return

  submitTree: ->
    @submit.prop('disabled', true)
    
    tree = @buildTree()
    tree = JSON.stringify( {tree: tree} )

    $.ajax
      type: 'POST'
      url: "/coupon_books/#{@couponBookId}/tree"
      dataType: 'json'
      headers:
        'Content-Type': 'application/json'
      data: tree
    return

  buildTree: ->
    categories = @getCategoriesPosition()
    coupons = (@getCouponsPosition(categoryId) for categoryId in categories)

    @tree[category] = coupons[index] for category, index in categories
    return @tree

  getCategoriesPosition: ->
    return @categoriesContainer.sortable('toArray')

  getCouponsPosition: (categoryId)->
    return @categoriesContainer.find("##{categoryId} ul.sortableCoupons").sortable('toArray')

  sortCategories: (categories)->
    self = this
    #Sort coupons inside Categories
    @categoriesWrappers.sortable(
      axis:'y'
      items: "li:not(.ui-state-disabled)",
      connectWith: ".sortableCoupons",
      update: (event, ui) ->
        #new CategorizedCoupon(ui.item, self.tree).update()
        return
    )

    #Categories Sorting
    @categoriesContainer.sortable({
      axis: 'y'
      items: "li.category"
      connectWith: ".sortableCategories"
    })
    return

  draggableCoupons: ->
    self = this

    #Collection Coupons dragging
    @collectionCoupons.draggable({
      connectToSortable: "#categories ul.sortableCoupons"
      cancel: ".in-book"
      containment: '#drag-canvas'
      helper: (event) ->
        clone = $(this).clone().css({width: $(this).width()})
        return clone
      revert: (valid, ui)->
        unless valid
          collectionCoupon = new CollectionCoupon($($(this).context))
          collectionCoupon.showInCollection()
        return !valid
      start: (event, ui) ->
        $(this).addClass('in-book')
        return
    })
    return

CakeCouponBook.coupon_books.dragging = (couponBookId)->
  new CouponBook(couponBookId)
  return    

