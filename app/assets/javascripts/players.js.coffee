$ ->
  $("#show-about").click (e) ->
    event.preventDefault()
    $("#about-expanded").toggle()

  $("#show-more-stats").click (e) ->
    event.preventDefault()
    $("#more-stats").toggle()
    $("#win-value tfoot").hide()

  $("#show-bio").click (e) ->
    event.preventDefault()
    $("#expanded-bio").toggle()
    $(this).hide()
