CakeCouponBook.overrides ?= {}

CakeCouponBook.overrides.init = ->
  checkbox()
  hide_alert()
  booleanButtonInput()
  booleanCollapse()
  return

booleanButtonInput = ->
  $('button.boolean-button-input').on 'click', (e) ->
    e.preventDefault()

    #Toggle classes
    oppositeButton = $(this).closest('.boolean-button-container').find('button.boolean-button-input')

    onClasses = $(this).data('on-classes')
    offClasses = $(this).data('off-classes')

    jsFunction = $(this).data('toggle-js')
    console.log jsFunction      
    eval(jsFunction)

    currentClasses = $.trim $(this).attr('class').replace('boolean-button-input', '').replace('btn', '')
    newClasses = if currentClasses == onClasses then offClasses else onClasses

    oppositeButton.removeClass().addClass("btn boolean-button-input #{currentClasses}")
    $(this).removeClass().addClass("btn boolean-button-input #{newClasses}")

    #Update hidden field
    input = $(this).closest('.boolean_button').find('input[type=hidden]')

    if input.length > 0
      if input.val().toString() != $(this).data('value').toString()
        input.val($(this).data('value')).trigger 'change'
    return

  return

booleanCollapse = ->
  input = $('#boolean-collapse-input')
  panel = $('#boolean_collapse_panel')

  if input.is(':checked')
    panel.collapse('show')
  else
    panel.collapse('hide')

  input.change ->
    if this.checked
      panel.collapse('show')
    else
      panel.collapse('hide')
    return
  return

hide_alert = ->
  whitelisted_messages = [
    'A message with a confirmation link has been sent to your email address. Please open the link to activate your account.'
  ]

  alert = $(".alert.fade.in")
  message = alert.text().slice(1)

  unless message in whitelisted_messages
    window.setTimeout (->
      alert.fadeTo(500, 0).slideUp 500, ->
        $(this).remove()
        return
      return
    ), 3500
  return

checkbox = ->
  $(".checkbox-pill").each (o) ->
    if !$(this).hasClass("done")
      textStr = $(this).parent("label").text()
      inputPH = $(this)
      $(this).text " "
      $(this).parent().html inputPH
      $("<label class='new-label' for='" + $(this).attr("id") + "'>" + textStr + "</label>").insertAfter $(this)
      $(this).last().addClass "done"
    return

  $(":checkbox:checked").each (o) ->
    chkID = $(this).attr("id")
    $(this).next().addClass "checked"
    return

  $("input[type='checkbox']").change ->
    if $(this).is(":checked")
      $(this).next().addClass "checked"
    else
      $(this).next().removeClass "checked"
    return
    
return  