FILTERS =
  filters: {
    'all': '.hos'
    'hof': '.hof'
    'hom': '.hom'
    'added': '.hos.not-hof'
    'removed': '.hof.not-hos'
    'upcoming': '.upcoming.not-hos'
    'active-and-worthy': '.active-and-worthy.not-hos',
    'active-and-close': '.active-and-close',
    'near-misses': '.near-miss',
    'position': '.position',
  }

  filterPlayers: (kind) ->
    listItems = $('#player-list li')
    listItems.hide()

    selector = @filters[kind] || @filters['all']
    listItems.filter(selector).show()

window.FILTERS = FILTERS

$ ->
  for position in ['p', 'c', '1b', '2b', '3b', 'ss', 'lf', 'cf', 'rf', 'dh']
    FILTERS.filters["#{position}"] = ".hos.#{position}"
