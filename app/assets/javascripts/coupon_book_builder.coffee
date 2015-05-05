class CollectionCoupon
  constructor: (@coupon) ->
    return

  showInCollection: ->
    @coupon.removeClass('in-book')
    return

  hideInCollection: ->
    @coupon.addClass('in-book')
    return

class Category
  constructor: (@category) ->
    @id = @category.attr('id').replace('coupon_categories_', '')
    @coupons = @category.find('li.collection-coupon')
    @nestedFormCounter = @category.closest('li.category').find('.hidden.input input[type="hidden"]').attr('name').split('][')[1]
    return

  update: ->
    couponsOrder = @category.sortable('toArray')
    @updateCouponPosition(couponId, index) for couponId, index in couponsOrder
    return

  updateCouponPosition: (couponId, index)->
    positionField = @category.find("##{couponId} .position-input input[type='hidden']")
    positionField.val(index+1)
    return

class Coupon
  constructor: (@coupon, category) ->
    @category = new Category(category)
    @categoryId = @category.id
    @couponId = @coupon[0].id
    @inCollection = new CollectionCoupon($("#collection-coupons li.collection-coupon##{@couponId}"))

    @idField = @coupon.find('.id-input input[type="hidden"]')
    @positionField = @coupon.find('.position-input input[type="hidden"]')
    @categoryIdField = @coupon.find('.category_id-input input[type="hidden"]')
    @couponIdField = @coupon.find('.coupon_id-input input[type="hidden"]')
    return

  update: ->
    #Current Coupon updates
    @updateFields()
    #Siblings updates
    @category.update()
    return

  updateFields: ->
    @categoryIdField.val(@categoryId)

    @replaceNestedFormCounter(@categoryIdField)
    @replaceNestedFormCounter(@positionField)
    @replaceNestedFormCounter(@couponIdField)
    return

  replaceNestedFormCounter: (field)->
    unless field.attr('name') is undefined
      newName = field.attr('name').replace(/\[categories_attributes\]\[(\d|category_counter)\]/, "[categories_attributes][#{@category.nestedFormCounter}]")
      field.attr('name', newName)
    return
  
class CategorizedCoupon extends Coupon
  constructor: (@coupon, category) ->
    super(@coupon, category)

    @init()
    return
  
  init: ->
    @grayOutInCollection()
    return

  grayOutInCollection: ->
    @inCollection.hideInCollection()
    return


class DraggedCoupon extends Coupon
  constructor: (@coupon, category) ->
    super(@coupon, category)

    @removeLink = @coupon.find('a.remove-from-book')

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
      self.removeFromBook()
      return
    return

  replaceTrashIcon: ->
    @removeLink.find('span').removeClass('glyphicon-trash').addClass('glyphicon-remove')
    return

  removeFromBook: ->
    @coupon.remove()
    @inCollection.showInCollection()
    return

class CouponBook
  constructor: (@couponBookId)->
    @form = $('#drag-canvas .formtastic.coupon_book')

    @collection = $("#collection-coupons")
    @collectionCoupons = @collection.find("li.collection-coupon")
    @categoriesContainer = $("#categories")
    @categoriesWrappers = @categoriesContainer.find("ul.sortableCoupons")
    @categories = @categoriesContainer.find('li.category')

    @domCategorizedCoupons = @categoriesWrappers.find('li.categorized-coupon')
    @categorizedCoupons = (new CategorizedCoupon($(coupon), $(coupon).closest('ul.sortableCoupons')) for coupon in @domCategorizedCoupons)

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
        new DraggedCoupon(ui.item, $(this))
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