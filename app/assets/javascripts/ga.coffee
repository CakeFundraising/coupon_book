CakeCouponBook.analytics ?= {}

class GoogleAnalytics
  constructor: (analyticsId) ->
    @analyticsId = analyticsId

    @load()
    return

  load: ->
    self = this
    # Google Analytics depends on a global _gaq array. window is the global scope.
    window._gaq = []
    window._gaq.push ["_setAccount", @analyticsId]

    # Create a script element and insert it in the DOM
    ga = document.createElement("script")
    ga.type = "text/javascript"
    ga.async = true
    ga.src = ((if "https:" is document.location.protocol then "https://ssl" else "http://www")) + ".google-analytics.com/ga.js"
    firstScript = document.getElementsByTagName("script")[0]
    firstScript.parentNode.insertBefore ga, firstScript

    # If Turbolinks is supported, set up a callback to track pageviews on page:change.
    # If it isn't supported, just track the pageview now.
    if typeof Turbolinks isnt 'undefined' and Turbolinks.supported
      $(document).on 'page:change', ->
        self.trackPageview()
        return
    else
      @trackPageview()
    return

  trackPageview: (url)->
    unless @isLocalRequest()
      if url
        window._gaq.push ["_trackPageview", url]
      else
        window._gaq.push ["_trackPageview"]

      window._gaq.push ["_trackPageLoadTime"]
    return
  
  isLocalRequest: ->
    document.domain.indexOf("local") isnt -1
    return

CakeCouponBook.analytics.set = (gaId)->
  new GoogleAnalytics(gaId)
  return