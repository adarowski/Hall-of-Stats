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

  $('input.autocomplete').autocomplete(
    source: (request, response) ->
      $.ajax '/autocomplete',
        type: 'POST',
        data: 'name=' + request.term,
        success: (data) ->
          response( $.map(data, (item) ->
            { label: item.full_name, value: item.id }))
    minLength: 2,
    select: (event, ui) ->
      event.target.value = ''
      document.location.href = '/player/' + ui.item.value
      false
  )
