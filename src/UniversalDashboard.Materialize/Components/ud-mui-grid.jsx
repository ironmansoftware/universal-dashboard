import React from 'react';
import ReactInterval from 'react-interval';
import MaterialTable from 'material-table';

import ErrorCard from './error-card.jsx';
import UdLink from './ud-link.jsx';
import CustomCell from './custom-cell.jsx';
import UDIcon from './ud-icon';

const icons = {
    Add: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref}></UDIcon>),
    Check: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref}></UDIcon>),
    Clear: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref}></UDIcon>),
    Delete: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref}></UDIcon>),
    DetailPanel: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref}></UDIcon>),
    Edit: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref}></UDIcon>),
    Export: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref} icon="FileExport"></UDIcon>),
    Filter: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref}></UDIcon>),
    FirstPage: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref} icon="ChevronCircleLeft"></UDIcon>),
    LastPage: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref} icon="ChevronCircleRight"></UDIcon>),
    NextPage: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref} icon="ChevronRight"></UDIcon>),
    PreviousPage: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref} icon="ChevronLeft"></UDIcon>),
    ResetSearch: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref} icon="Times"></UDIcon>),
    Search: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref} icon="Search"></UDIcon>),
    SortArrow: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref} icon="ArrowDown"></UDIcon>),
    ThirdStateCheck: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref}></UDIcon>),
    ViewColumn: React.forwardRef((props, ref) => <UDIcon {...props} ref={ref}></UDIcon>)
}

export default class UdGrid extends React.Component {
    constructor(props) {
        super(props);

        var defaultSortColumn = props.defaultSortColumn;
        if (props.defaultSortColumn == null && props.properties != null) {
            defaultSortColumn = props.properties[0];
        } else if (defaultSortColumn == null) {
            defaultSortColumn = ''
        }
    
        this.state = {
          data: [],
          filteredData: [],
          currentPage: 1,
          pageSize: props.pageSize,
          recordCount: 0,
          hasError: false,
          errorMessage: "",
          sortColumn: defaultSortColumn,
          sortAscending: !props.defaultSortDescending,
          filterText: "",
          properties: props.properties,
          headers: props.headers,
          loading: true,
          firstLoad: true
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
                if (property == null) continue;
                if (property.type === "element") {
                    for(var i = 0; i < property.events.length; i++) {
                        UniversalDashboard.publish('element-event', {
                            type: "unregisterEvent",
                            eventId: property.events[i].id
                        });
                    }
    
                    if (property.hasCallback) {
                        UniversalDashboard.publish('element-event', {
                            type: "unregisterEvent",
                            eventId: property.id
                        });
                    }
                }
            }
        });

        UniversalDashboard.unsubscribe(this.pubSubToken);
    }


    reload() {
        const { currentPage, pageSize, sortColumn, sortAscending, filterText } = this.state;
        this.loadData(currentPage, pageSize, sortColumn, sortAscending, filterText);
    }

    loadData(page, pageSize, sortColumn, sortAscending, filterText) {
        var skip = (page - 1) * pageSize;

        this.setState({
            loading: true
        })

        UniversalDashboard.get(`/api/internal/component/datatable/${this.props.id}?start=${skip}&length=${pageSize}&sortColumn=${sortColumn}&sortAscending=${sortAscending}&filterText=${filterText}`, function(json){
            
            this.setState({
                loading: false,
                firstLoad: false
            })

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
                    json.data = []
                }

                if (json.data.length == 1 && typeof json.data[0] === 'string')  {
                    json.data = []
                }

                if (Object.prototype.toString.call( json.data ) === '[object Array]' && json.data.length === 1) {
                    if (Object.prototype.toString.call( json.data[0] ) === '[object Array]' && json.data[0].length === 0)
                        json.data = []
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

        if (this.props.serverSideProcessing)
        {
            this.setState({filteredData: data})
        }
        else 
        {
            this.filter(filterText, data);
        }
        
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
        this.pubSubToken = UniversalDashboard.subscribe(this.props.id, this.onIncomingEvent.bind(this));
    }

    onPageChanged(x) {
        if (this.props.serverSideProcessing)
        {
            const { pageSize, sortColumn, sortAscending, filterText } = this.state;
            this.loadData(x, pageSize, sortColumn, sortAscending, filterText);
        }
        else
        {
            this.setState({
                currentPage: x
            })
        }
    }

    onExportData() {

        var csv = '';
        this.state.data.forEach(x => {
            for(var propertyName in x) {
                var property = x[propertyName];
                if (property == null) continue;

                csv += property + ",";
            }
            csv = csv.substr(0, csv.length - 1) + "\r\n";
        })

        var element = document.createElement('a');
        element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(csv));
        element.setAttribute('download', 'export.csv');
      
        element.style.display = 'none';
        document.body.appendChild(element);
      
        element.click();
      
        document.body.removeChild(element);
    }

    onLocalSort(sortProperties) {
        if (sortProperties.id !== this.state.sortColumn || sortProperties.sortAscending !== this.state.sortAscending) {
            this.setState({
                sortColumn: sortProperties.id,
                sortAscending: sortProperties.sortAscending
            })
        }
    }

    filter(filter, data) {
        if (filter !== "")
        {
            var filteredData = data.filter(x => {
                return Object.keys(x).find(y => {
                    var value = x[y];
                    const filterToLower = filter.toLowerCase();
                    return value && value.toString().toLowerCase().indexOf(filterToLower) > -1;
                }) != null
            });

            this.setState({ filteredData, filterText: filter, recordCount: filteredData.length });
        }
        else 
        {
            this.setState({filteredData: data, filterText: filter, recordCount: data.length })
        }
    }

    onLocalFilter(e) {
        this.filter(e.target.value, this.state.data);
    }

    render() {
        if (this.state.hasError) {
            return [<ErrorCard message={this.state.errorMessage} title={this.props.title} id={this.props.id} key={this.props.id} />, <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)}/>]
        }

        var columns = [];
        if (this.props.headers) {
            columns = this.props.headers.map(function(x, i) {
                return {
                    field: this.props.properties[i],
                    title: x, 
                    render: rowData => <CustomCell value={rowData[this.props.properties[i]]} dateTimeFormat={this.props.dateTimeFormat} />
                }
            }.bind(this));
        } else if (this.state.data != null && this.state.data.length > 0) {
            var i = 0;
            for(var key in this.state.data[0]) {
                columns.push({
                    field: key,
                    title: key, 
                    render: rowData => <CustomCell value={rowData[key]} dateTimeFormat={this.props.dateTimeFormat} />
                });
                i++;
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

        if (this.props.noFilter) {
            serverFilter = null;
            serverFilterControl = null;
        }

        if (this.state.firstLoad)
        {
            return <div className="card ud-grid" id={this.props.id} style={{background: this.props.backgroundColor, color: this.props.fontColor}} key={this.props.id}>
                <div className="card-content">
                    <span className="card-title">{this.props.title}</span>
                    <div className="progress"><div className="indeterminate"></div></div> 
                </div>
            </div>
        }

        return (
            <MaterialTable 
                        title={this.props.title}
                        style={{background: this.props.backgroundColor, color: this.props.fontColor}}
                        className="ud-grid"
                        columns={columns}
                        data={this.state.filteredData}
                        icons={icons}
                    />
               );
    }
}
