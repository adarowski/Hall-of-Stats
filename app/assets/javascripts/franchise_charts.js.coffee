$ ->
  shouldBeFading = true
  fadeLoader = () ->
    if shouldBeFading
      $('#waiting').fadeIn(1000)
        .delay(500)
        .fadeOut(1000, fadeLoader)

  fadeLoader()

  drawChart = (data, divId, showLegend, height) ->
    if data != null
      nv.addGraph(() ->
        chart = nv.models.stackedAreaChart()
          .showControls(false)
          .showLegend(showLegend)
          .x((d) -> +new Date(d[0], 0, 1))
          .y((d) -> d[1])
          .clipEdge(true)
        
        chart.xAxis
          .tickFormat((d) -> d3.time.format('%Y')(new Date(d)))

        chart.yAxis
          .tickFormat(d3.format(',d'))

        d3.select("#chart-container svg##{divId}")
          .attr('height', height)
          .datum(data)
          .transition().duration(500).call(chart)

        shouldBeFading = false
        $('#waiting').hide()
        nv.utils.windowResize(chart.update)
        chart
      )

  drawChart(json_data, 'total', false, 150)
  drawChart(all_time_team_data, 'all-time', true, 300)
