CakeCouponBook.overrides ?= {}

CakeCouponBook.overrides.init = ->
  checkbox()
  hide_alert()
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