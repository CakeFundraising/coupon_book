class CategoriesNav
  constructor: ->
    @nav = $('.book-nav')
    @navUl = @nav.find('ul.nav')
    @navLinks = @navUl.find('li a.book-nav-link')

    @navSection = @nav.find('.nav-section')
    @buttonSection = @nav.find('.buy_button_section')
    @navAboutLink = @nav.find('.nav-about-link')

    @loadTarget = $('#remote-items')
    @loadAllButton = @loadTarget.find('#see-more-link')
    @dealLinks = @loadTarget.find('.see-more-box')
    @spinner = @loadTarget.find('#spinner')
    return

  showButton: ->
    @buttonSection.show()
    return
    
  hideButton: ->
    @buttonSection.hide()
    return

  scrollNav: (link)->
    self = this

    catId = link.data('cid')
    cat = $("##{catId}")

    link.removeAttr('href').removeAttr('data-toggle')

    link.off('click').click ->
      #Active
      self.navUl.find('li').each ->
        $(this).removeClass('active')
        return

      link.closest('li').addClass('active')

      #Scroll
      $('html, body').animate { scrollTop: cat.offset().top - self.nav.height() }, 500
      return
    return

  seeAll: ->
    self = this

    @loadAllButton.click ->
      self.spinner.removeClass('hidden')
      $(this).hide()
      return

    @loadAllButton.on("ajax:success", (e, data, status, xhr) ->
      self.loadTarget.html(data)
      CakeCouponBook.expander()

      self.navLinks.each ->
        self.scrollNav($(this))
        return
      return
    ).on "ajax:error", (e, xhr, status, error) ->
      self.spinner.hide()
      self.loadAllButton.show()
      alert "There was an error, please reload this page and try again."
      return
    return

  dealSeeAll: ->
    self = this
    @dealLinks.click ->
      self.loadAllButton.click()
      return
    return

  initNavScrolling: ->
    self = this

    @navLinks.each ->
      #self.scrollNav($(this))
      $(this).click ->
        $('html, body').animate { scrollTop: $('#coupons.green').offset().top }, 500
        return
      return
    return

  setAffixes: ->
    self = this

    @hideButton()

    @nav.affix offset:
      top: self.nav.offset().top

    @nav.on 'affixed.bs.affix', ->
      self.navSection.removeClass('col-md-12').addClass('col-md-9')
      self.showButton()
      return

    @nav.on 'affix-top.bs.affix', ->
      self.navSection.removeClass('col-md-9').addClass('col-md-12')
      self.hideButton()
      return
    return

  loadFirstCategory: ->
    @navLinks.first().click()
    return

  init: ->
    @setAffixes()
    @seeAll()
    @dealSeeAll()
    @loadFirstCategory()
    @initNavScrolling()
    return

module.exports = CategoriesNav
  
