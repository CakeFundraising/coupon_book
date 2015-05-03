class CollectionCoupon
  constructor: (@coupon) ->
    return

  showInCollection: ->
    @coupon.removeClass('in-book')
    return

class Category
  constructor: (@category) ->
    @coupons = @category.find('li.collection-coupon')
    @couponsOrder = @category.sortable('toArray')
    return

  update: ->
    @updateCouponPosition(couponId, index) for couponId, index in @couponsOrder
    return

  updateCouponPosition: (couponId, index)->
    positionField = @category.find("##{couponId} .position-input input[type='hidden']")
    positionField.val(index)
    return

class CategorizedCoupon
  constructor: (@coupon, category) ->
    @couponId = @coupon.attr('id')
    @categoryId = @coupon[0].parentElement.id.replace('coupon_categories_', '')
    @position = @coupon.index()
    
    @category = new Category(category)
    @originalCopy = new CollectionCoupon($("#collection-coupons li.collection-coupon##{@couponId}"))
    @removeLink = @coupon.find('a.remove-from-book')

    #@positionField = @coupon.find('.position-input input[type="hidden"]')
    @categoryIdField = @coupon.find('.category_id-input input[type="hidden"]')

    @init()
    return

  init: ->
    @removeDestroyAttrs()
    @setUpRemoveFromCategoryLink()
    @replaceTrashIcon()
    @update()
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
    #Current Coupon updates
    @categoryIdField.val(@categoryId)
    #@positionField.val(@position)

    #Siblings updates
    @category.update()
    return

  destroy: ->
    @coupon.remove()
    @originalCopy.showInCollection()
    return


class CouponBook
  constructor: (@couponBookId)->
    @form = $('#drag-canvas .formtastic.coupon_book')

    @collection = $("#collection-coupons")
    @collectionCoupons = @collection.find("li.collection-coupon")
    @categoriesContainer = $("#categories")
    @categoriesWrappers = @categoriesContainer.find("ul.sortableCoupons")
    @categories = @categoriesContainer.find('li.category')

    @init()
    return

  init: ->
    @sortCategories()
    @draggableCoupons()
    return

  sortCategories: (categories)->
    self = this
    #Sort coupons inside Categories
    @categoriesWrappers.sortable(
      axis:'y'
      items: "li:not(.ui-state-disabled)",
      connectWith: ".sortableCoupons",
      update: (event, ui) ->
        new CategorizedCoupon(ui.item, $(this))
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

CakeCouponBook.coupon_books.build = (couponBookId)->
  new CouponBook(couponBookId)
  return