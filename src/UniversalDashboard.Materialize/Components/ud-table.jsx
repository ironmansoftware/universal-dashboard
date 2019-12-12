import React from 'react';
import ReactInterval from 'react-interval';

export default class UDTable extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            id: this.props.id,
            hasAction: this.props.hasAction,
            links: this.props.links,
            title: this.props.title,
            backgroundColor: this.props.backgroundColor,
            fontColor: this.props.fontColor,
            header: this.props.header,
            content: this.props.content,
            endpoint: this.props.endpoint,
            autoRefresh: this.props.autoRefresh,
            refreshInterval: this.props.refreshInterval,
            argumentList: this.props.argumentList,
            hidden: this.props.hidden, 
            firstLoad: true 
        }
    }

    onIncomingEvent(eventName, event) {
        if (event.type === "requestState") {
            var data = {
                attributes: this.state
            }
            UniversalDashboard.post(`/api/internal/component/element/sessionState/${event.requestId}`, data);
        }
        else if (event.type === "setState") {
            this.setState(event.state.attributes);
        }
        else if (event.type === "clearElement") {
            this.setState({
                content: null
            });
        }
        else if (event.type === "removeElement") {
            this.setState({
                hidden:true
            });
        }
        else if (event.type === "syncElement") {
            this.loadData();
        }
    }

    componentWillMount() {
        this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
        this.loadData();
    }
      
    componentWillUnmount() {
        UniversalDashboard.unsubscribe(this.pubSubToken);
    }

    loadData() {
        if (this.props.endpoint) {
            UniversalDashboard.get("api/internal/component/element/" + this.state.id, function(data) {
                if(data.error) {
                    this.setState({
                        content: data.error.message
                    })
                    return;
                }

                this.setState({
                    content: data,
                    firstLoad: false
                })
            }.bind(this));
        }
    }

    renderTableHeaders() {
        var tabIndex = 0;

        return this.state.header.map(x => {
            tabIndex++;
            return (
                <th>{this.state.header}.{tabIndex}</th>
            )
        });
    }

    renderTableBody() {
        var tabIndex = 0;
    
        return this.state.content.map(x => {
          tabIndex++;
          var tabIndex2 = 0;
          return (
            <tr>
            {this.state.content.tabIndex.map(y => {
              tabIndex2++;
              return (
                <td>{y}.{tabIndex2}</td>
              )
            })}
            </tr>
          )
        });
    }

    render() {
        if(this.state.hidden) {
            return null;
        }

        var style = {
            backgroundColor: this.state.backgroundColor,
            color: this.state.fontColor
        }

        var headers = this.renderTableHeaders;

        return (
            <div className='card ud-table' style={style} id={this.state.id}>
                <div className='card-content'>
                    <span className="card-title">{this.state.title}</span>
                    
                    <table>
                        <thead>
                            <tr>
                                {headers}
                            </tr>
                        </thead>
                        <tbody>
                            { this.state.firstLoad && this.state.endpoint ? 
                                <div className="progress"><div className="indeterminate"></div></div> :
                            this.state.content ?
                            this.renderTableHeaders
                            : <div>No results found</div>}
                        </tbody>
                    </table>
                    
                </div>
                <ReactInterval timeout={this.state.refreshInterval * 1000} enabled={this.state.autoRefresh} callback={this.loadData.bind(this)}/>
            </div>
        );
    }
}
