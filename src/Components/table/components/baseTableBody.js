import React from "react";
import { TableBody, TableCell, TableRow, IconButton, Collapse, Box } from "@mui/material";
import { setCellPadding, setEmptyRows } from "../v2/utilities";
import KeyboardArrowUpIcon from '@mui/icons-material/KeyboardArrowUp';
import KeyboardArrowDownIcon from '@mui/icons-material/KeyboardArrowDown';

function ExpandableRow({ row, render }) {
  const [open, setOpen] = React.useState(false);

  return (
    <React.Fragment>
      <TableRow sx={{ '& > *': { borderBottom: 'unset' } }}  {...row.getRowProps()}>
        <TableCell width={50}>
          <IconButton
            aria-label="expand row"
            size="small"
            onClick={() => setOpen(!open)}
          >
            {open ? <KeyboardArrowUpIcon /> : <KeyboardArrowDownIcon />}
          </IconButton>
        </TableCell>
        {row.cells.filter(cell => !cell.column.hidden).map((cell, index) => {
          return (
            <TableCell
              {...cell.getCellProps()}
              style={cell.column?.style}
              align={cell.column?.align}
              padding={setCellPadding(cell.column.id, index)}
            >
              {cell.render("Cell")}
            </TableCell>
          );
        })}
      </TableRow>
      <TableRow>
        <TableCell style={{ paddingBottom: 0, paddingTop: 0 }} colSpan={6}>
          <Collapse in={open} timeout="auto" unmountOnExit>
            <Box sx={{ margin: 1 }}>
              {render(row.original.rowexpanded)}
            </Box>
          </Collapse>
        </TableCell>
      </TableRow>
    </React.Fragment>
  );
}


export default function BaseTableBody({
  getTableBodyProps,
  prepareRow,
  totalData,
  pageSize,
  pageIndex,
  visibleColumns,
  // getCellProps,
  isDense,
  page,
  render
}) {
  return (
    <TableBody {...getTableBodyProps()}>
      {page.map((row, i) => {
        prepareRow(row);

        if (row.original.rowexpanded) {
          return <ExpandableRow row={row} render={render} />
        }

        return (
          <TableRow {...row.getRowProps()}>
            {row.cells.filter(cell => !cell.column.hidden).map((cell, index) => {
              return (
                <TableCell
                  {...cell.getCellProps()}
                  style={cell.column?.style}
                  align={cell.column?.align}
                  padding={setCellPadding(cell.column.id, index)}
                >
                  {cell.render("Cell")}
                </TableCell>
              );
            })}
          </TableRow>
        );
      })}
      {setEmptyRows({ totalData, pageSize, pageIndex, visibleColumns, isDense })}
    </TableBody>
  );
}