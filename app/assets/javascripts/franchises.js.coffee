$ ->
  $('.franchise #filters-ajax a').click (e) ->
    e.preventDefault()

    filterParts = this.href.split('#')
    filter = filterParts[filterParts.length - 1]

    document.location.hash = filter
    
    franchiseId = $('#players-with-rating.franchise-players').data('franchise')

    $('ol#player-list').html("<img src='/assets/preloader.gif' style='position: absolute; left: 50%; margin: 50px 0 0 -19px;' />")
    $.ajax "/franchise/#{franchiseId}/render_list",
      type: 'GET',
      data: "filter_type=#{filter}",
      success: (data) ->
        $('ol#player-list').html(data)

    $('#show-filters').text(this.text)
    $("#filters-ajax").slideToggle()
    
  $("#show-filters").click (e) ->
    e.preventDefault()
    $("#filters-ajax").slideToggle()
