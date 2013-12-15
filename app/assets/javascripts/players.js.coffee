filters = {
  'all': '.hos'
  'hof': '.hof'
  'hom': '.hom'
  'personal-hof': '.personal-hof'
  'ross-hof': '.ross-hof'
  'bryan-hof': '.bryan-hof'
  'dan-hof': '.dan-hof'
  'dalton-hof': '.dalton-hof'
  'added': '.hos.not-hof'
  'removed': '.hof.not-hos'
  'upcoming': '.upcoming.not-hos'
  'active-and-worthy': '.active-and-worthy.not-hos',
  'active-and-close': '.active-and-close',
  'near-misses': '.near-miss',
  'position': '.position',
}

for position in ['p', 'c', '1b', '2b', '3b', 'ss', 'lf', 'cf', 'rf', 'dh']
  filters["#{position}"] = ".hos.#{position}"

$.fn.iWouldLikeToAbsolutelyPositionThingsInsideOfFrickingTableCellsPlease = ->
  $el = undefined
  @each ->
    $el = $(this)
    newDiv = $("<div />",
      class: "innerWrapper"
      css:
        height: $el.height()
        width: "100%"
        position: "relative"
    )
    $el.wrapInner newDiv

$ ->
  $('.partial-season-stat').hide()

  $('.full-season-stat[data-year]').click (e) ->
    e.preventDefault()
    year = $(@).data('year')
    $("tr.partial-season-stat[class*=yr-#{year}]").slideToggle()
    
  $("#search-link").click (e) ->
    e.preventDefault()
    $("#search").slideToggle()
    $("#player-search").focus()

  $("#show-filters").click (e) ->
    e.preventDefault()
    $("#filters").slideToggle()

  $("#show-nav-link").click (e) ->
    e.preventDefault()
    $(".global nav").slideToggle()
    $("#search").slideToggle()

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
            { label: label, value: item.id, name: item.full_name }))
    minLength: 2,
    focus: (event, ui) ->
      event.preventDefault()
      $(@).val(ui.item.name)
    select: (event, ui) ->
      event.target.value = ''
      document.location.href = '/player/' + ui.item.value
      false
  )

  filterPlayers = (kind) ->
    listItems = $('#player-list li')
    listItems.hide()

    selector = filters[kind] || filters['all']
    listItems.filter(selector).show()

  $('#filters a').click (e) ->
    e.preventDefault()

    filterParts = this.href.split('#')
    filter = filterParts[filterParts.length - 1]

    document.location.hash = filter

    filterPlayers(filter)

    $('#show-filters').text(this.text)
    $("#filters").slideToggle()

  #load our filter
  if document.location.hash
    $('a[href=' + document.location.hash + ']').click()
    $("#filters").hide()
  else if document.location.href.match(/\/position\//)
    filterPlayers('position')
  else
    filterPlayers('all') unless document.location.href.match(/\/franchise\//)

  $("#seasonal-stats tbody th").iWouldLikeToAbsolutelyPositionThingsInsideOfFrickingTableCellsPlease()
