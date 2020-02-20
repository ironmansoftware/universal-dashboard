import React from 'react';

import { makeStyles } from '@material-ui/core/styles';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import Paper from '@material-ui/core/Paper';

const useStyles = makeStyles({
    table: {
      minWidth: 650,
    },
  });

const UDTable = (props) => {
    const classes = useStyles();

    var header = props.content.find(x => x.type === 'mu-table-header');
    var body = props.content.find(x => x.type === 'mu-table-body');

    var rows = body.rows.map(row => {
        return (
            <TableRow>
                {row.cells.map(cell => <TableCell>{UniversalDashboard.renderComponent(cell.content)}</TableCell>)}
            </TableRow>
        )
    })

    return (
        <TableContainer component={Paper} id={props.id} key={props.id} >
            <Table className={classes.table} stickyHeader={props.stickyHeader} size={props.size}>
                <TableHead>
                    <TableRow>
                        {header.headers.map(x => <TableCell>{UniversalDashboard.renderComponent(x.content)}</TableCell>)}
                    </TableRow>
                </TableHead>
                <TableBody>
                    {rows}
                </TableBody>
            </Table>
        </TableContainer>
    );
}

export default UDTable;