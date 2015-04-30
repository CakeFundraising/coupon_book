class CollectionCoupon
  constructor: (@coupon) ->
    return

  showInCollection: ->
    @coupon.removeClass('in-book')
    return

class CategorizedCoupon
  constructor: (@coupon) ->
    @originalCopy = new CollectionCoupon($("#collection-coupons li.collection-coupon##{@coupon.attr('id')}"))
    @removeLink = @coupon.find('a.remove-from-book')
    @init()
    return

  init: ->
    self = this
    @removeLink.removeAttr('data-confirm')
    @removeLink.removeAttr('data-method')
    @removeLink.removeAttr('href')
    @removeLink.click ->
      self.destroy()
      return
    return

  destroy: ->
    @coupon.remove()
    @originalCopy.showInCollection()
    return

class CouponBook
  constructor: ->
    #@form = $('.formtastic.coupon_book')

    @collection = $("#collection-coupons")
    @collectionCoupons = @collection.find("li.collection-coupon")
    @categoriesContainer = $("#categories")
    @categoriesWrappers = @categoriesContainer.find("ul.sortableCoupons")
    @categories = @categoriesContainer.find('li.category')

    #@greyOutUsedCoupons()
    @sortCategories()
    @draggableCoupons()
    #@removeFromBook()
    #@saveCouponBookOrder()
    return


  getCategoriesPosition = ->
    return @categoriesContainer.sortable('toArray')

  sortCategories: (categories)->
    self = this
    #Sort coupons inside Categories
    @categoriesWrappers.sortable(
      axis:'y'
      items: "li:not(.ui-state-disabled)",
      connectWith: ".sortableCoupons",
      update: (event, ui) ->
        #self.removeFromBook($(this))
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
        new CategorizedCoupon(clone)
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

  saveCouponBookOrder: ->
    self = this

    @form.submit (e)->
      self.saveCategoriesOrder()
      return true
    return

  saveCategoriesOrder: ->
    self = this

    @categoriesWrappers.each ->
      category = $(this)
      category_position = category.parent().index()
      category_input_id = "#" + category.attr('id').replace(/coupon_/, "") + "_position"
      $(category_input_id).val(category_position)
      self.saveCouponsOrder(category)
      return
    return

  saveCouponsOrder: (category)->
    category_id = category.attr('id').replace(/\D/g, '')

    category.children(".ui-state-default").each ->
      coupon = $(this)
      coupon_position = coupon.index()
      position_input_id = $(this).find('.position-input').find('input')
      category_input_id = $(this).find('.category_id-input').find('input')
      position_input_id.val(coupon_position)
      category_input_id.val(category_id)
      return
    return

  greyOutUsedCoupons: ->
    @categoriesContainer.find(".ui-state-default").each ->
      couponSelector = $(this).attr('class').split(' ')[1]
      coupon = @collection.find(".#{couponSelector}")
      coupon.addClass('in-book')
      return
    return

  removeFromBook: (container)->
    container = $('body') if container is undefined

    container.find("a.remove-from-book").click ->
      coupon_id = $(this).attr('id').replace(/\D/g, '')
      @categoriesContainer.find(".coupons__" + coupon_id).remove()
      @collection.find(".coupons__" + coupon_id).removeClass('in-book')
      return
    return

  removeFromCategory: (coupon)->
    coupon_class = @getCouponClass(coupon)
    @collection.find(".#{coupon_class}").removeClass("in-book")
    return

  getCouponClass: (coupon)->
    return $(coupon).attr('class').split(' ')[1]

CakeCouponBook.coupon_books.build = ->
  new CouponBook()
  return