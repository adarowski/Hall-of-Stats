$ ->
  $("#show-about").click (e) ->
    event.preventDefault()
    $("#about-expanded").slideToggle()

  $("#show-filters").click (e) ->
    event.preventDefault()
    $("#filters").slideToggle()

  $("#show-more-stats").click (e) ->
    event.preventDefault()
    $("#more-stats").slideToggle()
    $("#win-value tfoot").hide()

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
