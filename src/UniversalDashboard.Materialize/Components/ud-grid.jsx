import React from 'react';
import ReactInterval from 'react-interval';
import Griddle, { RowDefinition, ColumnDefinition, plugins } from 'griddle-react';
import ErrorCard from './error-card.jsx';
import UdLink from './ud-link.jsx';
import CustomCell from './custom-cell.jsx';
import { DebounceInput } from 'react-debounce-input';
import { Dropdown, Button, Row, Col } from 'react-materialize';
import UdIcon from './ud-icon.jsx';
import { saveAs } from 'file-saver';
function strMapToObj(strMap) {
    if (strMap == undefined) return null;
    if (strMap._tail != undefined && strMap._tail.array != undefined) {
        return strMap._tail.array.map(x => strMapToObj(x));
    }
    if (!strMap.__iterate) return strMap;

    let obj = Object.create({});
    for (let [k, v] of strMap) {
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

        var defaultSortColumn = props.defaultSortColumn;
        if (props.defaultSortColumn == null && props.properties != null) {
            defaultSortColumn = props.properties[0];
        } else if (defaultSortColumn == null) {
            defaultSortColumn = ''
        }

        this.state = {
            data: [],
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
            for (var propertyName in x) {
                var property = x[propertyName];
                if (property == null) continue;
                if (property.type === "element") {
                    for (var i = 0; i < property.events.length; i++) {
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

        UniversalDashboard.get(`/api/internal/component/datatable/${this.props.id}?start=${skip}&length=${pageSize}&sortColumn=${sortColumn}&sortAscending=${sortAscending}&filterText=${filterText}`, function (json) {

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
                    return
                }

                if (json.data.length == 1 && typeof json.data[0] === 'string') {
                    return;
                }

                if (Object.prototype.toString.call(json.data) === '[object Array]' && json.data.length === 1) {
                    if (Object.prototype.toString.call(json.data[0]) === '[object Array]' && json.data[0].length === 0)
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

    updateTableState({ data, currentPage, recordCount, sortColumn, sortAscending, filterText }) {
        if (Object.prototype.toString.call(data) !== '[object Array]') {
            data = []
        }
        this.setState({ data, currentPage, recordCount, hasError: false, sortColumn, sortAscending, filterText });
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
        this.setState({
            currentPage: x
        })
    }

    onExportData() {

        var csv = '';
        this.state.data.forEach(x => {
            for (var propertyName in x) {
                var property = x[propertyName];
                if (property == null) continue;

                csv += property + ",";
            }
            csv = csv.substr(0, csv.length - 1) + "\r\n";
        })

        var blob = new Blob([csv], { type: "text/csv;charset=utf-8" });
        saveAs(blob, "export.csv", { autoBom: true })
    }

    onLocalSort(sortProperties) {
        if (sortProperties.id !== this.state.sortColumn || sortProperties.sortAscending !== this.state.sortAscending) {
            this.setState({
                sortColumn: sortProperties.id,
                sortAscending: sortProperties.sortAscending
            })
        }
    }

    render() {
        if (this.state.hasError) {
            return [<ErrorCard message={this.state.errorMessage} title={this.props.title} id={this.props.id} key={this.props.id} />, <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.loadData.bind(this)} />]
        }

        var rowDefinition = null;
        if (this.props.headers) {
            var columns = this.props.headers.map(function (x, i) {
                return <ColumnDefinition key={i} id={this.props.properties[i]} title={x} customComponent={CustomColumn} dateTimeFormat={this.props.dateTimeFormat} />
            }.bind(this));

            rowDefinition = <RowDefinition>{columns}</RowDefinition>;
        } else if (this.state.data != null && this.state.data.length > 0) {
            var columns = [];
            var i = 0;
            for (var key in this.state.data[0]) {
                columns.push(<ColumnDefinition key={i.toString()} id={key} title={key} customComponent={CustomColumn} dateTimeFormat={this.props.dateTimeFormat} />)
                i++;
            }

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
            var links = this.props.links.map(function (x, i) {
                return <UdLink {...x} key={x.url} />
            });
            actions = <div className="card-action">
                {links}
            </div>
        }

        var gridPlugins = [];
        var serverSort, serverFilter, serverNext, serverPrev, serverGetPage, serverFilterControl;
        var components = {
            SettingsToggle: () => <span />,
            Pagination: () => <span />
        }
        var serverFilterControl = <DebounceInput name="filter" className="griddle-filter" type="text" placeholder={this.props.filterText} value={this.state.filterText} onChange={this.onFilter.bind(this)} debounceTimeout={300} />

        if (!this.props.serverSideProcessing) {
            gridPlugins = [plugins.LocalPlugin]
            serverFilterControl = null;

            if (this.props.noFilter) {
                components = {
                    ...components,
                    Filter: () => <span />
                }
            }
            serverSort = this.onLocalSort.bind(this);
        } else {
            serverSort = this.onSort.bind(this);
            serverFilter = this.onFilter.bind(this);
            serverPrev = this.onPreviousPage.bind(this);
            serverNext = this.onNextPage.bind(this);
            serverGetPage = this.onGetPage.bind(this);

            if (this.props.noFilter) {
                serverFilter = null;
                serverFilterControl = null;
            }

            components = {
                ...components,
                Filter: () => <span />
            }
        }

        return (
            <div className="card ud-grid" id={this.props.id} style={{ background: this.props.backgroundColor, color: this.props.fontColor }} key={this.props.id}>
                <div className="card-content">
                    <span className="card-title">{this.props.title}</span>

                    {serverFilterControl}
                    {this.state.firstLoad ?
                        <div className="progress"><div className="indeterminate"></div></div> :
                        rowDefinition ?
                            [<Griddle
                                data={this.state.data}
                                plugins={gridPlugins}
                                sortProperties={[{
                                    id: this.state.sortColumn,
                                    sortAscending: this.state.sortAscending
                                }]}
                                pageProperties={{
                                    currentPage: this.state.currentPage,
                                    pageSize: this.props.noPaging ? Number.MAX_SAFE_INTEGER : this.state.pageSize,
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
                            </Griddle>,
                            <GridToolbar
                                activePage={this.state.currentPage}
                                totalPages={Math.ceil(this.state.recordCount / this.state.pageSize)}
                                onPageChanged={this.onPageChanged.bind(this)}
                                onExportData={this.onExportData.bind(this)}
                                noExport={this.props.noExport}
                                reload={this.reload.bind(this)}
                                loading={this.state.loading}
                                noPaging={this.props.noPaging}
                            />]
                            : <div>No results found</div>}
                </div>

                {actions}
                <ReactInterval timeout={this.props.refreshInterval * 1000} enabled={this.props.autoRefresh} callback={this.reload.bind(this)} />
            </div>
        );
    }
}

class GridToolbar extends React.Component {
    render() {

        var cursor = {
            cursor: "pointer"
        }

        var pagination = null;
        if (!this.props.noPaging && this.props.totalPages > 1) {
            var pages = [];
            var startPage = this.props.totalPages > 10 ? this.props.activePage : 1;

            if (this.props.totalPages < (this.props.activePage + 10)) {
                startPage = this.props.totalPages - 10;
            }

            for (var i = startPage; i <= this.props.totalPages; i++) {

                if (i <= 0) continue;

                if (i > (startPage + 10)) {
                    break;
                }

                pages.push(<Page activePage={this.props.activePage} onPageChanged={this.props.onPageChanged} page={i} pointer />);
            }

            if (this.props.totalPages >= 10 && this.props.activePage < (this.props.totalPages - 10)) {
                pages.push(<Page activePage={this.props.activePage} page='...' />);
                pages.push(<Page activePage={this.props.activePage} onPageChanged={this.props.onPageChanged} page={this.props.totalPages} pointer />);
            }

            pagination = <ul className="pagination" style={{ display: 'inline-block' }} >
                <li className={this.props.activePage === 1 ? "disabled" : ""} style={this.props.activePage > 1 ? cursor : {}}><a onClick={() => this.props.activePage > 1 && this.props.onPageChanged(this.props.activePage - 1)}><UdIcon icon="ChevronLeft" /></a></li>
                {pages}
                <li className={this.props.activePage === this.props.totalPages ? "disabled" : ""} style={this.props.activePage < this.props.totalPages ? cursor : {}}><a onClick={() => this.props.activePage < this.props.totalPages && this.props.onPageChanged(this.props.activePage + 1)}><UdIcon icon="ChevronRight" /></a></li>
            </ul>
        }

        return (
            <Row>
                <Button
                    icon={<UdIcon icon="Sync" spin={this.props.loading} />}
                    style={{ display: 'inline-block', float: 'right', marginTop: '15px', marginLeft: '10px' }}
                    onClick={this.props.reload}
                    flat
                    tooltip="Refresh"
                    tooltipOptions={{ position: 'bottom' }}
                />
                <Button
                    icon={<UdIcon icon="Download" />}
                    style={{ display: this.props.noExport ? 'none' : 'inline-block', float: 'right', marginTop: '15px' }}
                    onClick={this.props.onExportData}
                    flat
                    tooltip="Export to CSV"
                    tooltipOptions={{ position: 'bottom' }}
                />
                {pagination}
            </Row>
        )
    }
}

class Page extends React.Component {
    render() {
        return <li className={this.props.activePage === this.props.page ? "active" : ""} style={{ cursor: this.props.pointer ? "pointer" : "default" }}><a onClick={() => this.props.onPageChanged(this.props.page)}>{this.props.page}</a></li>
    }
}