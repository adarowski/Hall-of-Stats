$ ->
  $("#show-about").click (e) ->
    event.preventDefault()
    $("#about").toggle()

  $("#show-bio").click (e) ->
    event.preventDefault()
    $("#expanded-bio").toggle()
    $(this).hide()
