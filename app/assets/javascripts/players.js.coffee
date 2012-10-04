filters = {
  'show-all': '.hos'
  'show-added': '.hos.not-hof'
  'show-removed': '.hof.not-hos'
  'show-upcoming': '.upcoming.not-hos'
}

for position in ['p', 'c', '1b', '2b', '3b', 'ss', 'lf', 'cf', 'rf', 'dh']
  filters["show-#{position}"] = ".hos.#{position}"

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

  filterPlayers = (kind) ->
    listItems = $('.player-list li')
    listItems.hide()
    listItems.filter(filters[kind]).show()

  $('#filters a').click (e) ->
    e.preventDefault()

    filterPlayers(this.id)

    $('#show-filters').text(this.text)
    $("#filters").slideToggle()

  # set our default filter
  filterPlayers('show-all')
