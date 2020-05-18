import React from 'react';
import {Doughnut, Bar, Line, Area} from 'react-chartjs-2';
import ReactInterval from 'react-interval';
import ErrorCard from './error-card.jsx'
import UdLink from './ud-link.jsx';
import UdInputField from './ud-input-field.jsx';

export default class UdMonitor extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            chartData: null,
            errorMessage: "",
            hasError: false,
            fields: props.filterFields
        }
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "syncElement") {
            this.loadData();
        }
    }

    componentWillUnmount() {
        UniversalDashboard.unsubscribe(this.pubSubToken);
    }

    onValueChanged(fieldName, value) {
        var fields = this.state.fields.map(function(x) {
            if (x.name === fieldName) {
                x.value = value;
            }

            return x;
        });

        this.setState({
            fields: fields
        });

        this.loadData();
    }

    loadData(){

        var queryString = "";
        
        if (this.state.fields != null) {
            queryString = "?"
            for(var i = 0; i < this.state.fields.length; i++) {
                var field = this.state.fields[i];

                queryString += field.name + "=" + escape(field.value) + "&";
            }

            queryString = queryString.substr(0, queryString.length - 1);
        }

        UniversalDashboard.get(`/api/internal/component/element/${this.props.id}${queryString}`,function(data){
                if (!this.chart) return;

                if (data.error) {
                    this.setState({
                        hasError: true, 
                        errorMessage: data.error.message
                    })
                    return;
                }

                var chart = this.chart.chartInstance;

                if (chart == null) {
                    console.log("Missing chart reference! " + JSON.stringify(data));
                    return;
                }

                if (data.length) {
                    for(var i = 0; i < data.length; i++) {
                        var dataItem = data[i];
    
                        chart.data.datasets[i].data.push(dataItem);
                        if (chart.data.datasets[i].data.length > this.props.dataPointRetention) {
                            chart.data.datasets[i].data.shift();
                        }
                    }
                }
                else {
                    chart.data.datasets[0].data.push(data);
                    if (chart.data.datasets[0].data.length > this.props.dataPointRetention) {
                        chart.data.datasets[0].data.shift();
                    }
                }
             
                chart.update();
            }.bind(this));
    }

    componentWillMount() {
        this.loadData();
        this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }
    
    renderArea(data, options) {
        return <Area ref={x => this.chart = x} data={data} options={options}/>
    }

    renderDoughnut(data, options) {
        return <Doughnut ref={x => this.chart = x} data={data} options={options}/>
    }

    renderBar(data, options) {
        return <Bar ref={x => this.chart = x} data={data} options={options}/>
    }

    renderLine(data, options) {
        return <Line ref={x => this.chart = x} data={data} options={options}/>
    }

    renderRadar(data, options) {
        return <Radar ref={x => this.chart = x} data={data} options={options}/>
    }

    render() {
        if (this.state.hasError) {
            return [<ErrorCard message={this.state.errorMessage} title={this.props.title} id={this.props.id} key={this.props.id}/>, <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>]
        }

        var datasets = new Array()
        for(var i = 0; i < this.props.labels.length; i++) {
            var dataset = {
                label: this.props.labels[i],
                backgroundColor: this.props.chartBackgroundColor[i],
                borderColor: this.props.chartBorderColor[i],
                borderWidth: this.props.borderWidth,
                data: []
            }

            datasets.push(dataset);
        }

        var data = {
            datasets: datasets
        }

        var fields = null;
        
        if (this.state.fields != null) {
            fields = this.state.fields.map(x => {
                return <UdInputField key={x.name} {...x} fontColor={this.props.fontColor} onValueChanged={this.onValueChanged.bind(this)} debounceTimeout={300}/> 
            });
        }

        var options = this.props.options;
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
            else 
            {
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
            options =  {
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
                layout:{
                    padding:{
                        bottom:25
                    }
                },
                maintainAspectRatio: true
            }

        }

        if(this.props.width !== null && this.props.height !== null){
            var cardStyle = {
                background:this.props.backgroundColor,
                color:this.props.fontColor,
                width:this.props.width,
                height:this.props.height,
                marginBottom:'3rem'
            }
            options.maintainAspectRatio = false
        }
        else if(this.props.width !== null && this.props.height === null){
            var cardStyle = {
                background:this.props.backgroundColor,
                color:this.props.fontColor,
                width:this.props.width,
            }
        }
        else if(this.props.width === null && this.props.height !== null){
            return [<ErrorCard message={'Width property is missing'} key={this.props.id} id={this.props.id} title={this.props.title}/>, <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>]
        }
        else{
            var cardStyle = {
                background:this.props.backgroundColor,
                color:this.props.fontColor,
            }
        }

        var chart = null;
        switch(this.props.chartType) {
            // Bar
            case 0:
                chart = this.renderBar(data, options);
                break;
            // Line
            case 1:
                chart = this.renderLine(data, options);
                break;
            // Area
            case 2:
                chart = this.renderArea(data, options);
                break;
            // Doughnut
            case 3:
                chart = this.renderDoughnut(data, options);
                break;
            // Radar
                case 3:
                chart = this.renderRadar(data, options);
                break;
        }

        var actions = null 
        if (this.props.links) {
            var links = this.props.links.map(function(x, i) {
                return <UdLink {...x} key={x.url} />
            });
            actions = <div className="card-action">
                {links}
            </div>
        }
        
        return <div className="card ud-monitor" id={this.props.id} key={this.props.id} style={{background:cardStyle.background,color:cardStyle.color,marginBottom:cardStyle.marginBottom}}>
                    <div className="card-content" style={{width:cardStyle.width,height:cardStyle.height}}>
                        <span className="card-title">{this.props.title}</span>
                        {chart}
                        {fields}
                        <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>
                    </div>
                    {actions}
                </div>
    }
}