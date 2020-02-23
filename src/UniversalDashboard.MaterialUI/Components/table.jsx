import React, {useEffect, useState} from 'react';
import MaterialTable from 'material-table';

import AddIcon from '@material-ui/icons/Add';
import CheckIcon from '@material-ui/icons/Check';
import ClearIcon from '@material-ui/icons/Clear';
import DeleteIcon from '@material-ui/icons/DeleteOutline';
import DetailPanelIcon from '@material-ui/icons/ChevronRight';
import EditIcon from '@material-ui/icons/Edit';
import ExportIcon from '@material-ui/icons/SaveAlt';
import FilterIcon from '@material-ui/icons/FilterList';
import FirstPageIcon from '@material-ui/icons/FirstPage';
import LastPageIcon from '@material-ui/icons/LastPage';
import NextPageIcon from '@material-ui/icons/ChevronRight';
import PreviousPageIcon from '@material-ui/icons/ChevronLeft';
import ResetSearchIcon from '@material-ui/icons/Clear';
import SearchIcon from '@material-ui/icons/Search';
import SortArrowIcon from '@material-ui/icons/ArrowUpward';
import ThirdStateCheckIcon from '@material-ui/icons/Remove';
import ViewColumnIcon from '@material-ui/icons/ViewColumn';
import { CircularProgress } from '@material-ui/core';
import { withComponentFeatures } from './universal-dashboard';

const icons = {
    Add: AddIcon,
    Check: CheckIcon,
    Clear: ClearIcon,
    Delete: DeleteIcon,
    DetailPanel: DetailPanelIcon,
    Edit: EditIcon,
    Export: ExportIcon,
    Filter: FilterIcon,
    FirstPage: FirstPageIcon,
    LastPage: LastPageIcon,
    NextPage: NextPageIcon,
    PreviousPage: PreviousPageIcon,
    ResetSearch: ResetSearchIcon,
    Search: SearchIcon,
    SortArrow: SortArrowIcon,
    ThirdStateCheck: ThirdStateCheckIcon,
    ViewColumn: ViewColumnIcon
}
const TableCell = (props) => {

    const [content, setContent] = useState({ loading: true})

    useEffect(() => {
        props.post(props.endpoint, props.rowData).then(x => setContent(x));

        return () => {}
    }, true)

    if (content.loading)
    {
        return <CircularProgress />
    }

    return props.render(content);
}

const UDTable = (props) => {

    const columns = props.columns.map(column => {

        var render = null;
        if (column.render)
        {
            render = (rowData) => <TableCell {...props} endpoint={column.render} rowData={rowData} />
        }

        return { 
            field: column.field, 
            title: column.title, 
            filtering: column.filter, 
            sorting: column.sort, 
            search: column.search,
            render
        }
    })

    var data = props.data;
    if (props.loadData) {
        data = (query) => {
            return new Promise((resolve, reject) => {
                props.loadData(query).then(x => resolve({
                    data: x,
                    page: 1,
                    totalCount: x.length
                }))
            });
        }
    }

    return (
        <div id={props.id} key={props.id}>
            <MaterialTable 
                title={props.title}
                icons={icons}
                columns={columns} 
                options={{
                    exportButton: props.export,
                    sorting: props.sort, 
                    filtering: props.filter,
                    search: props.search
                }}
                data={data} />
        </div>
    );
}

export default withComponentFeatures(UDTable);
