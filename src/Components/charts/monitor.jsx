import React, { useRef, useEffect, useState } from 'react';
import { Doughnut, Bar, Line, Area } from 'react-chartjs-2';
import ReactInterval from 'react-interval';
import { withComponentFeatures } from 'universal-dashboard'

const UdMonitor = (props) => {

    const chartRef = useRef();

    const load = () => {
        props.loadData().then(json => {
            if (!chartRef || !chartRef.current) {
                console.log("Missing chart reference! " + json);
            }

            var chart = chartRef.current.chartInstance;

            if (chart == null) {
                console.log("Missing chart reference! " + json);
                return;
            }

            const data = JSON.parse(json);

            if (data.length) {
                for (var i = 0; i < data.length; i++) {
                    var dataItem = data[i];

                    chart.data.datasets[i].data.push(dataItem);
                    if (chart.data.datasets[i].data.length > props.dataPointHistory) {
                        chart.data.datasets[i].data.shift();
                    }
                }
            }
            else {
                chart.data.datasets[0].data.push(data);
                if (chart.data.datasets[0].data.length > props.dataPointHistory) {
                    chart.data.datasets[0].data.shift();
                }
            }

            chart.update();
        })
    }

    useEffect(() => {
        load();
    }, [true])

    const renderArea = (data, options) => {
        return <Area ref={chartRef} data={data} options={options} />
    }

    const renderDoughnut = (data, options) => {
        return <Doughnut ref={chartRef} data={data} options={options} />
    }

    const renderBar = (data, options) => {
        return <Bar ref={chartRef} data={data} options={options} />
    }

    const renderLine = (data, options) => {
        return <Line ref={chartRef} data={data} options={options} />
    }

    const renderRadar = (data, options) => {
        return <Radar ref={chartRef} data={data} options={options} />
    }

    var chartBackgroundColor = props.chartBackgroundColor;
    if (!Array.isArray(chartBackgroundColor)) {
        chartBackgroundColor = [chartBackgroundColor]
    }

    var chartBorderColor = props.chartBorderColor;
    if (!Array.isArray(chartBorderColor)) {
        chartBorderColor = [chartBorderColor]
    }

    var datasets = new Array()
    for (var i = 0; i < props.labels.length; i++) {
        var dataset = {
            label: props.labels[i],
            backgroundColor: chartBackgroundColor.length === 1 ? chartBackgroundColor[0] : chartBackgroundColor[i],
            borderColor: chartBorderColor.length === 1 ? chartBorderColor[0] : chartBorderColor[i],
            borderWidth: props.borderWidth,
            data: []
        }

        datasets.push(dataset);
    }

    var data = {
        datasets: datasets
    }

    var options = props.options;
    if (options) {
        if (options.scales) {
            options.scales.xAxes = [{
                type: "time",
                time: {
                    // round: 'day'
                    tooltipFormat: 'll HH:mm'
                },
                scaleLabel: {
                    display: true
                }
            }]
        }
        else {
            options.scales = {
                xAxes: [{
                    type: "time",
                    time: {
                        // round: 'day'
                        tooltipFormat: 'll HH:mm'
                    },
                    scaleLabel: {
                        display: true
                    }
                },],
                yAxes: [{
                    scaleLabel: {
                        display: true
                    }
                }]
            }
        }
    } else {
        options = {
            legend: { display: true }, scales: {
                xAxes: [{
                    type: "time",
                    time: {
                        // round: 'day'
                        tooltipFormat: 'll HH:mm'
                    },
                    scaleLabel: {
                        display: true
                    }
                },],
                yAxes: [{
                    scaleLabel: {
                        display: true
                    }
                }]
            },
            layout: {
                padding: {
                    bottom: 25
                }
            },
            maintainAspectRatio: true
        }

    }

    var chart = null;
    switch (props.chartType.toLowerCase()) {
        // Bar
        case "bar":
            chart = renderBar(data, options);
            break;
        // Line
        case "line":
            chart = renderLine(data, options);
            break;
        // Area
        case "area":
            chart = renderArea(data, options);
            break;
        // Doughnut
        case "doughnut":
            chart = renderDoughnut(data, options);
            break;
        // Radar
        case "radar":
            chart = renderRadar(data, options);
            break;
    }

    return [
        chart,
        <ReactInterval timeout={props.refreshInterval * 1000} enabled={props.autoRefresh} callback={load} />
    ]
}

export default withComponentFeatures(UdMonitor);