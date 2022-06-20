import React from "react";
import { TableCell, TableHead, TableRow, TableSortLabel } from "@mui/material";
import { setCellPadding } from "../v2/utilities";

export default function BaseTableHead({ headerGroups, columns, expandable }) {


  function setTableSortLabel(column) {
    return column.id !== "selection" && column.getSortByToggleProps ? (
      <TableSortLabel
        active={column.isSorted}
        direction={column.isSortedDesc ? "desc" : "asc"}
      />
    ) : null;
  }

  return (
    <TableHead>
      {headerGroups.map((headerGroup) => (
        <React.Fragment>
          <TableRow {...headerGroup.getHeaderGroupProps()}>
            {expandable && <TableCell />}
            {headerGroup.headers.filter((column, index) => !column.hidden).map((column, index) => (
              <TableCell
                {...(column.id === "selection" || !column.getSortByToggleProps
                  ? column.getHeaderProps()
                  : column.getHeaderProps(column.getSortByToggleProps()))}
                align={column.align}
                padding={setCellPadding(column.id, index)}
                style={{
                  fontWeight: 600
                }}
              >
                {column.render("Header")}
                {setTableSortLabel(column)}
              </TableCell>
            ))}
          </TableRow>
          <TableRow
            style={{
              display: !columns.some((column) => column.showFilter) && "none",
            }}
          >
            {expandable && <TableCell />}
            {headerGroup.headers.filter((column, index) => !column.hidden).map((column, index) => (
              <TableCell padding={setCellPadding(column.id, index)}>
                {column.showFilter ? column.render("Filter") : null}
              </TableCell>
            ))}
          </TableRow>
        </React.Fragment>
      ))}
    </TableHead>
  );
}