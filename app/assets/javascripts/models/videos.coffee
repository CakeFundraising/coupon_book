CakeCouponBook.videos ?= {}

class Video
  constructor: (args) ->
    @modal = $(args.modal)
    @embedIn = args.embedIn

    @provider = args.provider
    @id = args.iframeId
    @width = args.width
    @height = args.height

    @autoshow = args.autoshow

    @onModalShown()
    @onModalHidden()
    return

  showModal: ->
    @modal.modal('show')
    return

  hideModal: ->
    @modal.modal('hide')
    return

  onModalShown: ->
    self = this
    @modal.on "shown.bs.modal", (e) ->
      self.playVideo()
      return
    return

  onModalHidden: ->
    self = this
    @modal.on "hidden.bs.modal", (e) ->
      self.stopVideo()
      return
    return

class YoutubeVideo extends Video
  constructor: (args) ->
    super args

    @player = new YT.Player(@id,
      height: @height || "400"
      width: @width || "100%"
    )
    return

  playVideo: ->
    @player.playVideo()
    return

  stopVideo: ->
    @player.stopVideo()
    return

class VimeoVideo extends Video
  constructor: (args) ->
    super args

    @iframe = $("iframe##{@id}")[0]
    @player = $f(@iframe)
    return
  
  playVideo: ->
    @player.api('play')
    return

  stopVideo: ->
    @player.api('pause')
    return


# Youtube API
CakeCouponBook.videos.youtubeApi = ->
  tag = document.createElement("script")
  tag.src = "https://www.youtube.com/iframe_api"

  firstScriptTag = document.getElementsByTagName("script")[0]
  firstScriptTag.parentNode.insertBefore tag, firstScriptTag
  return

CakeCouponBook.videos.queueFunctions = (fn)->
  CakeCouponBook.videos.apiQueue ?= []
  CakeCouponBook.videos.apiQueue.push(fn)
  return

CakeCouponBook.videos.ytApiReady = ->
  fn() for fn in CakeCouponBook.videos.apiQueue
  return

#Init functions
CakeCouponBook.videos.youtube = (options) ->
  new YoutubeVideo(options)
  return

CakeCouponBook.videos.vimeo = (options) ->
  new VimeoVideo(options)
  return

#Other functions
CakeCouponBook.videos.autoshow = ->
  $('#video_modal').modal('show') if CakeCouponBook.videos.autoshow_setting
  return

CakeCouponBook.videos.restartOnModalHidden = (modal_id)->
  $(modal_id).on "hidden.bs.modal", (e) ->
    $(modal_id + " iframe").attr "src", $(modal_id + " iframe").attr("src")
    return
  return

