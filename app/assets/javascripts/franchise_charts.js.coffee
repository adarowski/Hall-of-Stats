$ ->
  drawChart = (my_data, div) ->
    margin = { top: 20, right: 50, bottom: 30, left: 55 }
    height = 120 - margin.top - margin.bottom
    width = 750 - margin.left - margin.right

    x = d3.scale.linear()
      .range([0, width])
      .domain([my_data[0].range_year, my_data[my_data.length - 1].range_year])

    y = d3.scale.linear()
      .range([height, 0])
      .domain(d3.extent(my_data, (d) -> d.sum))

    area = d3.svg.area()
      .x((d) -> x(d.range_year))
      .y0(y(0))
      .y1((d) -> y(d.sum))

    svg = d3.select(div)
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
      .append('g')
      .attr('transform', "translate(#{margin.left}, #{margin.top})")

    xAxisPoints = x.domain().concat((year for year in [x.domain()[0]..x.domain()[1]] when year % 20 == 0 && year >= x.domain()[0] + 10))

    svg.selectAll('line.x')
      .data(xAxisPoints)
      .enter().append('line')
      .attr('class', 'x')
      .attr('x1', x)
      .attr('x2', x)
      .attr('y1', y(0))
      .attr('y2', y.range()[1])
      .style('stroke', '#ccc')

    svg.selectAll('line.y')
      .data((n for n in y.domain() when n >= 0))
      .enter().append('line')
      .attr('class', 'y')
      .attr('x1', 0)
      .attr('x2', x.range()[1])
      .attr('y1', y)
      .attr('y2', y)
      .style('stroke', '#ccc')

    xAxis = d3.svg.axis()
      .scale(x)
      .orient('bottom')
      .tickValues(xAxisPoints)
      .tickFormat(d3.format('d'))

    yAxis = d3.svg.axis()
      .scale(y)
      .orient('left')
      .tickValues(y.domain())
      .tickFormat(d3.format(',.2f'))

    svg.append('g')
      .attr('class', 'x axis')
      .attr('transform', "translate(0, #{y(0)})")
      .call(xAxis)

    svg.append('g')
      .attr('class', 'y axis')
      .call(yAxis)

    svg.append('path')
      .datum(my_data)
      .attr('class', 'area')
      .attr('d', area)
      .attr('fill', color)

    svg.selectAll('circle')
      .data(my_data)
      .enter().append('circle')
      .attr('class', 'data-point')
      .attr('r', 5)
      .attr('cx', (d) -> x(d.range_year))
      .attr('cy', (d) -> y(d.sum))
      .on('mouseover', (d) ->
        $('.tooltip').css({left: d3.event.pageX - 25, top: $(div).position().top - 30})
        $('.tooltip .title').html(d.range_year)
        $('.tooltip .content').html(d3.format(',.2f')(d.sum))
        $('.tooltip').show()
      )
      .on('mouseout', () ->
        $('.tooltip').hide()
      )
  
  drawChart(my_data, 'svg#total')
  #drawChart(my_data, 'svg#all-time')
