import React from 'react';
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

const UDTable = (props) => {

    const columns = props.columns.map(column => {
        return { 
            field: column.field, 
            title: column.title, 
            filtering: column.filter, 
            sorting: column.sort, 
            search: column.search,
            render: column.component
        }
    })

    return (
        <MaterialTable 
            title={props.title}
            icons={icons}
            columns={columns} 
            data={props.data} />
    );
}

export default UDTable;
