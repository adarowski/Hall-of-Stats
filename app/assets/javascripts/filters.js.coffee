$ ->
  # load our filter
  if document.location.hash
    $('a[href=' + document.location.hash + ']').click()
    $("#filters, #filters-ajax").hide()
  else if document.location.href.match(/\/position\//)
    filterPlayers('position')
  else
    filterPlayers('all') unless document.location.href.match(/\/franchise\//)
