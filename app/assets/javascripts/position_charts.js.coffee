$ ->
  chart = new Highcharts.Chart({
    chart: {
      renderTo: 'chartContainer',
      type: 'spline'
    },
    title: {
      text: chart_title
    },
    yAxis: {
      title: {
        text: 'Hall Rating'
      }
    },
    xAxis: {
      tickInterval: 1,
      title: {
        text: 'Best Seasons'
      }
    },
    series: all_data,
    tooltip: {
      headerFormat: '<span style="color:{series.color}">{series.name}</span>:<br />',
      pointFormat: "Season ranked #\{point.x} - {point.year} <br />Hall Rating: {point.y}"
    },
    credits: { enabled: false }
  })
