CakeCouponBook.pictures ?= {}
CakeCouponBook.crop ?= {}

########### Objects =================================================================
CakeCouponBook.pictures.uriConstants = CakeCouponBook.pictures.avatarConstants =
  ratio: 1.5
  versions:
    medium:
      x: 300
      y: 200

CakeCouponBook.pictures.bannerConstants =
  ratio: 2
  versions:
    large:
      x: 1400
      y: 700
    medium:
      x: 340
      y: 170

CakeCouponBook.pictures.qrcodeConstants =
  ratio: 1
  versions:
    medium:
      x: 300
      y: 300

########### Classes =================================================================
##### Image Class ####
class UploadedImage
  constructor: (image) ->
    @image = image
    @width = image.width
    @height = image.height
    @ratio = @calculate_ratio()
    @modal_width = @calculate_modal_width()
    @modal_height = @calculate_modal_height()

    @delete_token = image.delete_token
    return

  calculate_ratio: =>
    ratio = if @width > 667 then (@width*0.0015) else 1
    return ratio

  calculate_modal_width: =>
    return Math.round @width/@ratio

  calculate_modal_height: =>
    return Math.round @height/@ratio

  validate_image: ->
    if @width <= CakeCouponBook.pictures.avatarConstants.versions.medium.x
      @cancel()
      CakeCouponBook.crop.modal.hide()
      alert 'Please upload an image greater than 305x230px'
    return

  destroy_in_cloudinary: ->
    $.cloudinary.delete_by_token(@delete_token)
    return

  cancel: ->
    @destroy_in_cloudinary()

    #Reset coordinates
    if CakeCouponBook.crop.cropper
      CakeCouponBook.crop.cropper.x.removeAttr('value')
      CakeCouponBook.crop.cropper.y.removeAttr('value')
      CakeCouponBook.crop.cropper.w.removeAttr('value')
      CakeCouponBook.crop.cropper.h.removeAttr('value')

    # Remove hidden tag
    $('input[type="hidden"][name="' + CakeCouponBook.crop.input.data('cloudinary-field') + '"]').remove()
    return

##### Cropper Picture #####
class Cropper
  constructor: (ratio, minSize_x, minSize_y) ->
    @img_ratio = CakeCouponBook.pictures.current.ratio

    @modal = CakeCouponBook.crop.modal.$
    @input = CakeCouponBook.crop.input

    @x = CakeCouponBook.crop.coords_container.find('.crop_x')
    @y = CakeCouponBook.crop.coords_container.find('.crop_y')
    @w = CakeCouponBook.crop.coords_container.find('.crop_w')
    @h = CakeCouponBook.crop.coords_container.find('.crop_h')

    @modal.find('#image-container img').Jcrop
      aspectRatio: ratio
      minSize: [Math.round(minSize_x/@img_ratio), Math.round(minSize_y/@img_ratio)]
      setSelect: [0, 0, minSize_x, minSize_y]
      onSelect: (coords) =>
        @update(coords)
        return
      onChange: (coords) =>
        @update(coords)
        return
    , ->
      CakeCouponBook.crop.Jcrop = this
      return

  update: (coords) ->
    @x.val( Math.round(coords.x*@img_ratio) )
    @y.val( Math.round(coords.y*@img_ratio) )
    @w.val( Math.round(coords.w*@img_ratio) )
    @h.val( Math.round(coords.h*@img_ratio) )
    return

class CroppedImage
  constructor: (image) ->
    @image = image
    return

  load_cloudinary_image: ->
    image_tag = $.cloudinary.image(@image.public_id,
      crop: 'crop'
      x: CakeCouponBook.crop.cropper.x.val()
      y: CakeCouponBook.crop.cropper.y.val()
      width: CakeCouponBook.crop.cropper.w.val()
      height: CakeCouponBook.crop.cropper.h.val()
      class: 'img-responsive img-thumbnail'
    )

    CakeCouponBook.crop.image_previewer.html image_tag
    return

  show: ->
    @load_cloudinary_image()
    CakeCouponBook.crop.modal.show_success_message()
    return

class CropModal
  constructor: (modal) ->
    @modal = modal
    @$ = modal

    @header = @modal.find('.modal-header')
    @body = @modal.find('.modal-body')
    @footer = @modal.find('.modal-footer')
    @title = @header.find('.modal-title')
    @dialog = @modal.find('.modal-dialog')

    @loader_section = $('#no_upload')
    @image_container = $('#image-container')
    @success_container = @body.find('.success')

    @crop_button = @modal.find('#crop_button')
    @cancel_button = @modal.find('button[data-dismiss="modal"]')

    @upload_text = 'Uploading your image...'
    @cropping_text = 'Select a region to crop.'

    @bind_events()

  bind_events: ->
    self = this

    @modal.on 'hidden.bs.modal', ->
      self.reset()
      return

    @cancel_button.click ->
      CakeCouponBook.pictures.current.cancel()
      return

    @crop_button.click ->
      cropped_image = new CroppedImage(CakeCouponBook.pictures.current.image)
      cropped_image.show()
      return

  show: ->
    @modal.modal('show')
    return

  hide: ->
    @modal.modal('hide')
    return

  reset: ->
#Destroy Jcrop tracker
    CakeCouponBook.crop.Jcrop.destroy() if CakeCouponBook.crop.Jcrop

    #Reset modal title
    @title.text @upload_text

    #Show hidden sections
    @loader_section.show()
    @header.show()
    @footer.show()

    #Reset modal size
    @dialog.removeAttr('style')

    #Remove uploaded image
    @image_container.empty()
    @image_container.show()
    return

  display_cropping: (image)->
#hide loading section
    @loader_section.hide()

    #Change header title
    @title.text @cropping_text

    #Show cloudinary image
    @body.find('#image-container').html(
      $.cloudinary.image(image.public_id,
        format: image.format
        crop: 'fit'
        width: CakeCouponBook.pictures.current.modal_width
        height: CakeCouponBook.pictures.current.modal_height
      )
    )

    @dialog.width(CakeCouponBook.pictures.current.modal_width + 2)

    #start JCrop
    typeConstants = eval "CakeCouponBook.pictures." + CakeCouponBook.crop.type + "Constants"
    CakeCouponBook.crop.cropper = new Cropper(
      typeConstants.ratio,
      typeConstants.versions.medium.x,
      typeConstants.versions.medium.y
    )

    @footer.show() #hidden on #251
    return

  show_success_message: ->
    message = "<div class='lead crop-success'>Your new " + CakeCouponBook.crop.type + " picture is in preview mode, please SAVE this form to store it permanently.</div>"

    #Hide header, footer and image
    @header.hide()
    @footer.hide()
    @image_container.hide()

    #Show message on modal
    @success_container.html message

    #Hide modal automatically
    modal = @modal
    success_container = @success_container

    setTimeout (->
#Hide modal
      modal.modal('hide')
      #Remove success message
      success_container.empty()
      return
    ), 3000

    #Set validation
    eval('CakeCouponBook.crop.' + CakeCouponBook.crop.type + 'Present = true;')
    return

class ImageValidSizes
  constructor: ->
    @minWidth = CakeCouponBook.pictures.avatarConstants.versions.medium.x
    @minHeight = CakeCouponBook.pictures.avatarConstants.versions.medium.y
    @maxWidth = 5000
    @maxHeight = 5000
    return

########### Functions =================================================================
CakeCouponBook.crop.main = (image)->
  CakeCouponBook.pictures.current = new UploadedImage(image)
  CakeCouponBook.pictures.current.validate_image()

  CakeCouponBook.crop.modal.display_cropping(image)
  return

CakeCouponBook.crop.uploader = (selector) ->
  selector.cloudinary_fileupload
    add: (e, data) ->
      CakeCouponBook.crop.jqXHR = data
      return
    change: (e, data)->
      image = new Image()
      validator = new ImageValidSizes()

      image.onload = ->
        if this.width < validator.minWidth or this.height < validator.minHeight
          alert 'Please upload an image greater than ' + validator.minWidth + 'x' + validator.minHeight + 'px'
          CakeCouponBook.crop.jqXHR.abort()
        else if this.width > validator.maxWidth or this.height > validator.maxHeight
          alert 'Please upload an image smaller than ' + validator.maxWidth + 'x' + validator.maxHeight + 'px'
          CakeCouponBook.crop.jqXHR.abort()
        else
          CakeCouponBook.crop.jqXHR.submit()
        return

      _URL = window.URL || window.webkitURL
      image.src = _URL.createObjectURL(data.files[0])
      return
  return

CakeCouponBook.crop.init = (selector)->
  CakeCouponBook.crop.modal = new CropModal( $('#crop_modal') )
  CakeCouponBook.crop.input_selector = selector || $('.cloudinary-fileupload')

  #Initialize Cloudinary
  CakeCouponBook.crop.uploader(CakeCouponBook.crop.input_selector)

  CakeCouponBook.crop.input_selector.on 'cloudinarystart', ->
# Store vars
    CakeCouponBook.crop.input = $(this)
    CakeCouponBook.crop.type = $(this).data('cloudinary-field').split("[")[$(this).data('cloudinary-field').split("[").length - 1].replace("]", '')
    CakeCouponBook.crop.image_previewer = $(this).siblings('.uploader .'+ CakeCouponBook.crop.type)
    CakeCouponBook.crop.coords_container = $('#' + CakeCouponBook.crop.type + '_coords')

    #Show modal
    CakeCouponBook.crop.modal.show()
    CakeCouponBook.crop.modal.footer.hide()

    #Start when upload complete
    $(this).on 'cloudinarydone', (e, data)->
      CakeCouponBook.crop.main(data.result)
      return
    return

  CakeCouponBook.crop.input_selector.on 'cloudinaryprogressall', (e, data)->
    progress = parseInt(data.loaded/data.total * 100, 10);
    $('#overlay_loading').html '<span class="upload-progress">' + progress + '&#37;</span>'
    return

  return