CakeCouponBook.utils ?= {}

remoteTabs = ->
  $('[data-toggle="remoteTab"]').click (e) ->
    e.preventDefault()

    $this = $(this)
    loadUrl = $this.attr('href')
    $targ = $($this.attr('data-target'))
    callback = $this.attr('data-callback')

    if $targ.is(':empty')
      $.get loadUrl, (data) ->
        $targ.html data
        $targ.css('background', 'none')
        $this.attr('href', $this.attr('data-target'))
        $this.attr('data-toggle', 'tab')
        
        CakeCouponBook.expander()
        eval(callback) if callback
        return

    $this.tab 'show'
    return
  return

inputOnlyNumbers = ->
  allowed = [
    8,9,37,39,
    48,49,50,51,52,53,54,55,56,57,
    96,97,98,99,100,101,102,103,104,105
  ]

  $('.numbersOnly').keydown (e)->
    valid = $.inArray(e.which, allowed) > -1

    unless valid
      e.preventDefault()
    return
  return

CakeCouponBook.utils.init = ->
  remoteTabs()
  inputOnlyNumbers()
  return