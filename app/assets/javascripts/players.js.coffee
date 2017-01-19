$.fn.iWouldLikeToAbsolutelyPositionThingsInsideOfFrickingTableCellsPlease = ->
  $el = undefined
  @each ->
    $el = $(this)
    newDiv = $("<div />",
      class: "innerWrapper"
      css:
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

  $("#show-more-stats").click (e) ->
    e.preventDefault()
    $("#more-stats").slideToggle()
    $("#win-value tfoot").hide()

  $("#show-more-articles").click (e) ->
    e.preventDefault()
    $("li.extra").show()
    $(this).hide()

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

  $('#filters a').click (e) ->
    e.preventDefault()

    filterParts = this.href.split('#')
    filter = filterParts[filterParts.length - 1]

    document.location.hash = filter

    FILTERS.filterPlayers(filter)

    $('#show-filters').text(this.text)
    $("#filters").slideToggle()

  $("#seasonal-stats tbody th").iWouldLikeToAbsolutelyPositionThingsInsideOfFrickingTableCellsPlease()
  $(".graham-table tbody td").iWouldLikeToAbsolutelyPositionThingsInsideOfFrickingTableCellsPlease()
