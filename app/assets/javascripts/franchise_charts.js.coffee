$ ->
  shouldBeFading = true
  fadeLoader = () ->
    if shouldBeFading
      $('#waiting').fadeIn(1000)
        .delay(500)
        .fadeOut(1000, fadeLoader)

  fadeLoader()

  nv.addGraph(() ->
    chart = nv.models.stackedAreaChart()
      .showControls(false)
      .showLegend(false)
      .x((d) -> +new Date(d[0], 0, 1))
      .y((d) -> d[1])
      .clipEdge(true)

    chart.xAxis
      .tickFormat((d) -> d3.time.format('%Y')(new Date(d)))

    chart.yAxis
      .tickFormat(d3.format(',.2f'))

    d3.select('#chart-container svg#total')
      .attr('height', 150)
      .datum(json_data)
      .transition().duration(500).call(chart)

    shouldBeFading = false
    $('#waiting').hide()
    nv.utils.windowResize(chart.update)
    chart
  )

  nv.addGraph(() ->
    chart = nv.models.stackedAreaChart()
      .showControls(false)
      .x((d) -> +new Date(d[0], 0, 1))
      .y((d) -> d[1])
      .clipEdge(true)

    chart.xAxis
      .tickFormat((d) -> d3.time.format('%Y')(new Date(d)))

    chart.yAxis
      .tickFormat(d3.format(',.2f'))

    d3.select('#chart-container svg#all-time')
      .attr('height', 200)
      .datum(all_time_team_data)
      .transition().duration(500).call(chart)

    nv.utils.windowResize(chart.update)
    chart
  )
