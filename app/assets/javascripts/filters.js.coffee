FILTERS =
  filters: {
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
    'eligible-2016': '.eligible-2016'
    'eligible-2017': '.eligible-2017'
    'eligible-2018': '.eligible-2018'
    'eligible-2019': '.eligible-2019'
    'eligible-2020': '.eligible-2020'
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
