import React from 'react';
import {Row, Col} from 'react-materialize';
import {Doughnut, Bar, Line, Polar, Radar, Pie} from 'react-chartjs-2';
import {fetchGet} from './services/fetch-service.jsx';
import ReactInterval from 'react-interval';
import ErrorCard from './error-card.jsx'
import UdLink from './ud-link.jsx';
import UdInputField from './ud-input-field.jsx';
import PubSub from 'pubsub-js';

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

    componentWillUnmount() {
        PubSub.unsubscribe(this.pubSubToken);
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

        fetchGet(`/component/element/${this.props.id}${queryString}`, function(json){
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
        this.pubSubToken = PubSub.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }
    
    renderArea() {
            return <Polar data={this.state.chartData} options={this.props.options}/>
    }

    renderDoughnut() {
            return <Doughnut data={this.state.chartData} options={this.props.options}/>
    }

    renderBar() {
        return <Bar  data={this.state.chartData} options={this.props.options}/>
    }

    renderLine() {
        return <Line data={this.state.chartData} options={this.props.options}/>
    }

    renderRadar() {
        return <Radar data={this.state.chartData} options={this.props.options}/>
    }

    renderPie() {
        return <Pie data={this.state.chartData} options={this.props.options}/>
    }

    render() {
        if (this.state.hasError) {
            return [<ErrorCard message={this.state.errorMessage} key={this.props.id} id={this.props.id} title={this.props.title}/>, <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>]
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
            this.props.options = {
                maintainAspectRatio: false,
                layout:{
                    padding:{
                        bottom:25
                    }
                }
            }

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
            }
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