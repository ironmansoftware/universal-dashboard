import React from 'react';
import ReactInterval from 'react-interval';
import Griddle, { RowDefinition, ColumnDefinition, plugins } from 'griddle-react';
import {fetchGet} from './services/fetch-service.jsx';
import ErrorCard from './error-card.jsx';
import UdLink from './ud-link.jsx';
import CustomCell from './basics/custom-cell.jsx';
import {DebounceInput} from 'react-debounce-input';
import PubSub from 'pubsub-js';

function strMapToObj(strMap) {
    if (strMap == undefined) return null;
    if (strMap._tail != undefined && strMap._tail.array != undefined) {
        return strMap._tail.array.map(x => strMapToObj(x));
    } 
    if (!strMap.__iterate) return strMap;

    let obj = Object.create({});
    for (let [k,v] of strMap) {
        // We don’t escape the key '__proto__'
        // which can cause problems on older engines
        obj[k] = strMapToObj(v);
    }
    return obj;
}

class CustomColumn extends React.Component {
    render() {
        var value = strMapToObj(this.props.value);
        return <CustomCell value={value} dateTimeFormat={this.props.cellProperties.dateTimeFormat} />;
    }
}

export default class UdGrid extends React.Component {
    constructor(props) {
        super(props);
    
        this.state = {
          data: [],
          currentPage: 1,
          pageSize: props.pageSize,
          recordCount: 0,
          hasError: false,
          errorMessage: "",
          sortColumn: props.defaultSortColumn ? props.defaultSortColumn : props.properties[0],
          sortAscending: !props.defaultSortDescending,
          filterText: ""
        };
      }

    onIncomingEvent(eventName, event) {
        if (event.type === "syncElement") {
            this.reload();
        }
    }

    componentWillUnmount() {
        this.state.data.forEach(x => {
            for(var propertyName in x) {
                var property = x[propertyName];
                if (property.type === "element") {
                    for(var i = 0; i < property.events.length; i++) {
                        PubSub.publish('element-event', {
                            type: "unregisterEvent",
                            eventId: property.events[i].id
                        });
                    }
    
                    if (property.hasCallback) {
                        PubSub.publish('element-event', {
                            type: "unregisterEvent",
                            eventId: property.id
                        });
                    }
                }
            }
        });

        PubSub.unsubscribe(this.pubSubToken);
    }


    reload() {
        const { currentPage, pageSize, sortColumn, sortAscending, filterText } = this.state;
        this.loadData(currentPage, pageSize, sortColumn, sortAscending, filterText);
    }

    loadData(page, pageSize, sortColumn, sortAscending, filterText) {
        var skip = (page - 1) * pageSize;

        fetchGet(`/api/internal/component/datatable/${this.props.id}?start=${skip}&length=${pageSize}&sortColumn=${sortColumn}&sortAscending=${sortAscending}&filterText=${filterText}`, function(json){
            if (json.error) {
                this.setState({
                    hasError: true,
                    errorMessage: json.error.message
                })
            } else {
                if (!json.data.length) {
                    json.data = [json.data]
                }

                if (json.data.length === 1 && json.data[0] === null) {
                    return
                }

                if (json.data.length == 1 && typeof json.data[0] === 'string')  {
                    return;
                }

                if (Object.prototype.toString.call( json.data ) === '[object Array]' && json.data.length === 1) {
                    if (Object.prototype.toString.call( json.data[0] ) === '[object Array]' && json.data[0].length === 0)
                        return;
                }

                this.updateTableState({
                    data: json.data,
                    currentPage: page,
                    recordCount: json.recordsTotal,
                    sortColumn: sortColumn,
                    sortAscending: sortAscending,
                    filterText: filterText
                })
            }

        }.bind(this));
    }

    updateTableState({data, currentPage, recordCount, sortColumn, sortAscending, filterText}) {
        if (Object.prototype.toString.call( data ) !== '[object Array]' ) {
            data = []
        }
        this.setState({ data, currentPage, recordCount, hasError: false, sortColumn, sortAscending , filterText});
    }

    onSort(sortProperties) {
        const { currentPage, pageSize, filterText } = this.state;
        this.loadData(currentPage, pageSize, sortProperties.id, sortProperties.sortAscending, filterText);
    }

    onFilter(e) {
        const { currentPage, pageSize, sortColumn, sortAscending } = this.state;
        this.loadData(currentPage, pageSize, sortColumn, sortAscending, e.target.value);
    }

    onNextPage() {
        const { currentPage, pageSize, sortColumn, sortAscending, filterText } = this.state;
        this.loadData(currentPage + 1, pageSize, sortColumn, sortAscending, filterText);
    }

    onPreviousPage() {
        const { currentPage, pageSize, sortColumn, sortAscending, filterText } = this.state;
        this.loadData(currentPage - 1, pageSize, sortColumn, sortAscending, filterText);
    }

    onGetPage(pageNumber) {
        const { pageSize, sortColumn, sortAscending, filterText } = this.state;
        this.loadData(pageNumber, pageSize, sortColumn, sortAscending, filterText);
    }

    componentWillMount() {
        const { currentPage, pageSize, sortColumn, sortAscending, filterText } = this.state;
        this.loadData(currentPage, pageSize, sortColumn, sortAscending, filterText);
        this.pubSubToken = PubSub.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }

    render() {
        if (this.state.hasError) {
            return [<ErrorCard message={this.state.errorMessage} title={this.props.title} id={this.props.id} key={this.props.id} />, <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>]
        }

        var rowDefinition = null;
        if (this.props.headers) {
            var columns = this.props.headers.map(function(x, i) {
                return <ColumnDefinition key={i} id={this.props.properties[i]} title={x} customComponent={CustomColumn} dateTimeFormat={this.props.dateTimeFormat}/>
            }.bind(this));

            rowDefinition = <RowDefinition>{columns}</RowDefinition>;
        }

        const styleConfig = {
            classNames: {
                NextButton: "btn",
                PreviousButton: "btn"
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

        var gridPlugins = [];
        var serverSort, serverFilter, serverNext, serverPrev, serverGetPage, serverFilterControl;
        var components = {
            SettingsToggle: () => <span />
        }
        var serverFilterControl = <DebounceInput name="filter" className="griddle-filter" type="text" placeholder={this.props.filterText} value={this.state.filterText} onChange={this.onFilter.bind(this)} debounceTimeout={300} />
        
        if (!this.props.serverSideProcessing) {
            gridPlugins = [plugins.LocalPlugin]
            serverFilterControl = null;
        } else {
            serverSort = this.onSort.bind(this);
            serverFilter = this.onFilter.bind(this);
            serverPrev = this.onPreviousPage.bind(this);
            serverNext = this.onNextPage.bind(this);
            serverGetPage = this.onGetPage.bind(this);

            components = {
                Filter: () => <span/>,
                SettingsToggle: () => <span />
            }
        }

        return (
            <div className="card ud-grid" id={this.props.id} style={{background: this.props.backgroundColor, color: this.props.fontColor}} key={this.props.id}>
                <div className="card-content">
                    <span className="card-title">{this.props.title}</span>
                    {serverFilterControl}
                    <Griddle 
                        data={this.state.data}
                        plugins={gridPlugins}
                        sortProperties={[{
                            id: this.state.sortColumn,
                            sortAscending: this.state.sortAscending
                        }]}
                        pageProperties={{
                            currentPage: this.state.currentPage,
                            pageSize: this.state.pageSize,
                            recordCount: this.state.recordCount,
                        }}
                        events={{
                            onSort: serverSort,
                            onFilter: serverFilter,
                            onNext: serverNext,
                            onPrevious: serverPrev,
                            onGetPage: serverGetPage,
                        }}
                        components={components}
                        styleConfig={styleConfig}
                    >
                        {rowDefinition}
                    </Griddle>
                </div>
                {actions}
                <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.reload.bind(this)}/>
            </div>
               );
    }
}