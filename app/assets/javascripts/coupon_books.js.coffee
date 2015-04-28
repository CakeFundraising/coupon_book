CakeCouponBook.coupon_books ?= {}

CakeCouponBook.coupon_books.validation = ->
  $('.formtastic.coupon_book').validate(
    errorElement: "span"
    rules:
      'coupon_book[name]': 
        required: true
      'coupon_book[goal]':
        required: true
        currency: ["$", false]
      'coupon_book[launch_date]':
        required: true
      'coupon_book[end_date]':
        required: true
      'coupon_book[mission]':
        required: true
      'coupon_book[headline]':
        required: true
      'coupon_book[story]':
        required: true
      'coupon_book[goal]':
        required: true
        minStrict: 0
      'coupon_book[url]':
        required: true
        url: true
  )
  return

visibility = ->
  containers = $('.visibility_buttons')
  links = containers.find('a')

  links.on("ajax:success", (e, data, status, xhr) ->
    current = $(this)
    opposite = current.siblings("a")

    opposite.removeClass "hidden"
    current.addClass "hidden"
    return
  ).on "ajax:error", (e, xhr, status, error) ->
    alert "There were an error when updating coupon_book, please reload this page and try again."
    return
  return

launch = ->
  buttons = $('.launch_button')
  launched_button = '<div class="btn btn-sm btn-success disabled">Launched</div>'

  buttons.on("ajax:success", (e, data, status, xhr) ->
    current = $(this)
    current.closest('td').html(launched_button)
    return
  ).on "ajax:error", (e, xhr, status, error) ->
    alert "There were an error when updating coupon_book, please reload this page and try again."
    return
  return


class CouponBook
  constructor: ->
    @form = $('.formtastic.coupon_book')

    @collectionList = $("#my_coupons")
    @collectionCoupons = @collectionList.children(".ui-state-default")
    @categories = $("#categories")
    @categoriesContainers = @categories.find("ul.sortableCoupons")

    @greyOutUsedCoupons()
    @sortCategories()
    @draggableCoupons()
    @removeFromBook()
    @saveCouponBookOrder()
    return

  saveCouponBookOrder: ->
    self = this

    @form.submit (e)->
      self.saveCategoriesOrder()
      return true
    return

  saveCategoriesOrder: ->
    self = this

    @categoriesContainers.each ->
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
    @categories.find(".ui-state-default").each ->
      couponSelector = $(this).attr('class').split(' ')[1]
      coupon = $("#my_coupons").find(".#{couponSelector}")
      coupon.addClass('in-book')
      return
    return

  removeFromBook: (container)->
    container = $('body') if container is undefined

    container.find("a.remove-from-book").click ->
      coupon_id = $(this).attr('id').replace(/\D/g, '')
      $("#categories").find(".coupons__" + coupon_id).remove()
      $("#my_coupons").find(".coupons__" + coupon_id).removeClass('in-book')
      return
    return

  removeFromCategory: (coupon)->
    coupon_class = @getCouponClass(coupon)
    @collectionList.find(".#{coupon_class}").removeClass("in-book")
    return

  getCouponClass: (coupon)->
    return $(coupon).attr('class').split(' ')[1]

  sortCategories: (categories)->
    self = this

    @categoriesContainers.sortable(
      items: "li:not(.ui-state-disabled)",
      connectWith: ".sortableCoupons",
      stop: (event, ui) ->
        self.removeFromBook($(this))
        return
    ).disableSelection()

    @categories.sortable({
      connectWith: ".sortableCategories"
    }).disableSelection()
    return

  draggableCoupons: ->
    self = this

    @collectionCoupons.draggable({
      connectToSortable: ".sortableCoupons",
      revert: "invalid",
      cancel: ".in-book",
      helper: (event) ->
        original = if $(event.target).hasClass("ui-draggable") then $(event.target) else $(event.target).closest(".ui-draggable")
        original.clone().css({ width: original.width() })
        return
      ,
      start: (event, ui) ->
        ui.helper.find("input").each ->
          collection_id = $(this).attr('id')
          collection_name = $(this).attr('name')
          category_id = collection_id.replace(/collections/g, "categories")
          category_name = collection_name.replace(/collections/g, "categories")
          category_id = category_id.replace(/collection/g, "category")
          category_name = category_name.replace(/collection/g, "category")
          $(this).attr("id", category_id)
          $(this).attr('name', category_name)
          return

        coupon_class = self.getCouponClass(this)
        $(this).addClass('in-book')

        ui.helper.on("remove", ->
          self.removeFromCategory(this)
        )
      ,
      stop: (event, ui) ->
        coupon_class = $(this).attr('class').split(' ')[1]
        $("#my_coupons").find("." + coupon_class).removeClass("in-book") if $("#categories").find("." + coupon_class).length == 0
        return
    }).disableSelection()
    return

CakeCouponBook.coupon_books.build = ->
  new CouponBook()
  return

CakeCouponBook.coupon_books.init = ->
  visibility()
  launch()
  return