$ ->
  $('.franchise #filters-ajax a').click (e) ->
    console.log 'ok...'
    e.preventDefault()

    filterParts = this.href.split('#')
    filter = filterParts[filterParts.length - 1]

    document.location.hash = filter
    
    franchiseId = $('#inductees.franchise').data('franchise')

    $('ol.player-list').html("<img src='/assets/knuckle.gif' style='margin-left:5px;' />")
    $.ajax "/franchise/#{franchiseId}/render_list",
      type: 'GET',
      data: "filter_type=#{filter}",
      success: (data) ->
        $('ol.player-list').html(data)

    $('#show-filters').text(this.text)
    $("#filters-ajax").slideToggle()
    
  $("#show-filters").click (e) ->
    e.preventDefault()
    $("#filters-ajax").slideToggle()
