$ ->
  if document.location.hash
    $('a[href=' + document.location.hash + ']').click()
    $("#filters, #filters-ajax").hide()
  else if document.location.href.match(/\/position\//)
    FILTERS.filterPlayers('position')
  else
    FILTERS.filterPlayers('all') unless document.location.href.match(/\/franchise\//)

