filters = {
  'show-all': '.hos'
  'show-added': '.hos.not-hof'
  'show-removed': '.hof.not-hos'
  'show-upcoming': '.upcoming.not-hos'
  'show-active-and-worthy': '.active-and-worthy.not-hos'
}

for position in ['p', 'c', '1b', '2b', '3b', 'ss', 'lf', 'cf', 'rf', 'dh']
  filters["show-#{position}"] = ".hos.#{position}"

$ ->

  $(".home #player-search").focus()
  $("#search").hide()
  $(".home #search").show()

  $("#search-link").click (e) ->
    e.preventDefault()
    $("#search").slideToggle()
    $("#player-search").focus()

  $("#show-filters").click (e) ->
    e.preventDefault()
    $("#filters").slideToggle()

  $("#show-more-stats").click (e) ->
    e.preventDefault()
    $("#more-stats").slideToggle()
    $("#win-value tfoot").hide()

  $('input.autocomplete').autocomplete(
    html: true,
    source: (request, response) ->
      $.ajax '/autocomplete',
        type: 'POST',
        data: 'name=' + request.term,
        success: (data) ->
          response( $.map(data, (item) ->
            label = "#{item.full_name}"
            label += " <span class='years-played'> (#{item.years_played})</span>" if item.years_played != ""
            { label: label, value: item.id }))
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
