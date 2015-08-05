CakeCouponBook.facebook ?= {}
CakeCouponBook.facebook.pixel ?= {}

CakeCouponBook.facebook.pixel.conversion = (value)->
  _fbq = window._fbq || (window._fbq = [])

  if(!_fbq.loaded)
    fbds = document.createElement('script')
    fbds.async = true
    fbds.src = '//connect.facebook.net/en_US/fbds.js'
    s = document.getElementsByTagName('script')[0]
    s.parentNode.insertBefore(fbds, s)
    _fbq.loaded = true
    
  window._fbq = window._fbq || []
  window._fbq.push(['track', '6027184927100', {'value': value,'currency':'USD'}])
  return

CakeCouponBook.facebook.pixel.audience = ->
  !((f, b, e, v, n, t, s) ->
    if f.fbq
      return
    n =
    f.fbq = ->
      if n.callMethod then n.callMethod.apply(n, arguments) else n.queue.push(arguments)
      return

    if !f._fbq
      f._fbq = n
    n.push = n
    n.loaded = !0
    n.version = '2.0'
    n.queue = []
    t = b.createElement(e)
    t.async = !0
    t.src = v
    s = b.getElementsByTagName(e)[0]
    s.parentNode.insertBefore t, s
    return
  )(window, document, 'script', '//connect.facebook.net/en_US/fbevents.js')

  fbq('init', '1446660035631233')
  fbq('track', 'PageView')
  return