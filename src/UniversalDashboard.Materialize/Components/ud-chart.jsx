import React,{Suspense} from 'react';
import {Row, Col} from 'react-materialize';
import {Doughnut, Bar, Line, Polar, Radar, Pie, HorizontalBar} from 'react-chartjs-2';
import ReactInterval from 'react-interval';
import UdInputField from './ud-input-field.jsx';

const UdLinkComponent = React.lazy(() => import('./ud-link.jsx' /* webpackChunkName: "ud-link" */))
const UdErrorCardComponent = React.lazy(() => import('./error-card.jsx' /* webpackChunkName: "ud-error-card" */))

export default class UdChart extends React.Component {
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

    onChartClicked(elements) {

        if (!this.props.clickable) {
            return;
        }

        UniversalDashboard.publish('element-event', {
            type: "clientEvent",
            eventId: this.props.id + "onClick",
            eventName: 'onClick',
            eventData: JSON.stringify(elements.map(this.mapChartData))
        });
    }

    mapChartData(element) {
        var label = element._chart.data.labels[element._index];
        var value = element._chart.data.datasets[element._datasetIndex].data[element._index];

        return {
            ...element._view, 
            label, 
            value
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

        UniversalDashboard.get(`/api/internal/component/element/${this.props.id}${queryString}`, function(json){
                if (json.error) {
                    this.setState({
                        hasError: true, 
                        errorMessage: json.error.message
                    })
                } else {
                    this.setState({
                        chartData: json
                    });
                }
            }.bind(this));
    }

    componentWillMount() {
        this.loadData();
        this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }
    
    renderArea() {
            return <Polar data={this.state.chartData} options={this.props.options} onElementsClick={this.onChartClicked.bind(this)}/>
    }

    renderDoughnut() {
            return <Doughnut data={this.state.chartData} options={this.props.options} onElementsClick={this.onChartClicked.bind(this)}/>
    }

    renderBar() {
        return <Bar  data={this.state.chartData} options={this.props.options} onElementsClick={this.onChartClicked.bind(this)}/>
    }

    renderLine() {
        return <Line data={this.state.chartData} options={this.props.options} onElementsClick={this.onChartClicked.bind(this)}/>
    }

    renderRadar() {
        return <Radar data={this.state.chartData} options={this.props.options} onElementsClick={this.onChartClicked.bind(this)}/>
    }

    renderPie() {
        return <Pie data={this.state.chartData} options={this.props.options} onElementsClick={this.onChartClicked.bind(this)}/>
    }

    renderHorizontalBar() {
        return <HorizontalBar data={this.state.chartData} options={this.props.options} onElementsClick={this.onChartClicked.bind(this)}/>
    }

    render() {
        if (this.state.hasError) {
            return [
                <Suspense fallback={<div>Loading...</div>}>
                    <UdErrorCardComponent message={this.state.errorMessage} key={this.props.id} id={this.props.id} title={this.props.title}/>, <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>
                </Suspense>
                ]
        }

        var fields = null;
        
        if (this.state.fields != null) {
            fields = this.state.fields.map(x => {
                return <Col><UdInputField key={x.name} {...x} fontColor={this.props.fontColor} onValueChanged={this.onValueChanged.bind(this)} debounceTimeout={300}/></Col> 
            });

            fields = <Row>{fields}</Row>
        }
        
        if(this.props.width !== null && this.props.height !== null){
            var cardStyle = {
                background:this.props.backgroundColor,
                color:this.props.fontColor,
                width:this.props.width,
                height:this.props.height,
                marginBottom:'3rem'
            }
            var options = {
                maintainAspectRatio: false,
                layout:{
                    padding:{
                        bottom:25
                    }
                }
            }

            this.props.options = {...options, ...this.props.options}

        }
        else if(this.props.width !== null && this.props.height === null){
            var cardStyle = {
                background:this.props.backgroundColor,
                color:this.props.fontColor,
                width:this.props.width,
            }
        }
        else if(this.props.width === null && this.props.height !== null){
            return [
                <Suspense fallback={<div>Loading...</div>}>
                    <UdErrorCardComponent message={'Width property is missing'} key={this.props.id} id={this.props.id} title={this.props.title}/>, <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>
                </Suspense>
            ]

        }
        else{
            var cardStyle = {
                background:this.props.backgroundColor,
                color:this.props.fontColor,
            }
        }

        var chart = null;
        if (this.state.chartData != null) {
            switch(this.props.chartType) {
                // Bar
                case 0:
                    chart = this.renderBar();
                    break;
                // Line
                case 1:
                    chart = this.renderLine();
                    break;
                // Area
                case 2:
                    chart = this.renderArea();
                    break;
                // Doughnut
                case 3:
                    chart = this.renderDoughnut();
                    break;
                // Radar
                case 4:
                chart = this.renderRadar();
                    break;
                // Pie
                case 5:
                chart = this.renderPie();
                    break;
                // Horizontal Bar
                case 6:
                chart = this.renderHorizontalBar();
                    break;
            }
        }

        var actions = null 
        if (this.props.links) {
            var links = this.props.links.map(function(x, i) {
                return <Suspense fallback={<div>Loading...</div>}>
                    <UdLinkComponent {...x} key={x.url} />
                </Suspense>
            })
            actions = <div className="card-action">
                {links}
            </div>
        }

        return <div className="card ud-chart" key={this.props.id} id={this.props.id} style={{background:cardStyle.background,color:cardStyle.color,marginBottom:cardStyle.marginBottom}}>
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