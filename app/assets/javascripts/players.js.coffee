$ ->
  $("#show-about").click (e) ->
    event.preventDefault()
    $("#about-expanded").toggle()

  $("#show-more-stats").click (e) ->
    event.preventDefault()
    $("#more-stats").toggle()
    $(this).hide()

  $("#show-bio").click (e) ->
    event.preventDefault()
    $("#expanded-bio").toggle()
    $(this).hide()
