$ ->
  shouldBeFading = true
  fadeLoader = () ->
    if shouldBeFading
      $('#waiting').fadeIn(1000)
        .delay(500)
        .fadeOut(1000, fadeLoader)

  fadeLoader()

  d3.json('/franchise/all_data.json', (data) ->
    nv.addGraph(() ->
      chart = nv.models.stackedAreaChart()
        .showControls(false)
        .x((d) -> +new Date(d[0], 0, 1))
        .y((d) -> d[1])
        .clipEdge(true)
        .yDomain([0, 2000])

      chart.controls.width(0)
      chart.legend.width(800)

      chart.xAxis
        .tickFormat((d) -> d3.time.format('%x')(new Date(d)))

      chart.yAxis
        .tickFormat(d3.format(',.2f'))

      d3.select('#chart svg')
        .attr('height', 800)
        .datum(data)
        .transition().duration(500).call(chart)

      shouldBeFading = false
      $('#waiting').hide()
      nv.utils.windowResize(chart.update)
      chart
    )
  )
