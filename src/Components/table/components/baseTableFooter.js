//@ts-check
import React from "react"
import { TableFooter, TablePagination, TableRow, LinearProgress } from "@mui/material";
import TablePaginationActions from "../v2/TablePaginationActions";
import { onlyUnique } from "../v2/utilities";

export default function BaseTableFooter({
  userPageSize,
  userPageSizeOptions,
  colSpan,
  count,
  pageIndex,
  gotoPage,
  setPageSize,
  pageSize,
  isVisible,
  loading,
  disablePageSizeAll,
}) {
  function onChangePage(_, newPage) {
    gotoPage(newPage);
  }

  function onChangeRowsPerPage(event) {
    setPageSize(Number(event.target.value));
  }

  var rowsPerPageOptions = [
    userPageSize,
    ...userPageSizeOptions,
  ]

  if (!disablePageSizeAll) {
    rowsPerPageOptions.push({ label: "All", value: count })
  }

  return (
    isVisible && <TableFooter>
      <TableRow>
        {loading ? <LinearProgress style={{ marginTop: '20px', marginLeft: '10px' }} /> : <React.Fragment />}
        {!loading && count === 0 && <div className="MuiTableCell-root MuiTableCell-footer MuiTablePagination-root MuiTableCell-alignLeft">No data</div>}
        <TablePagination
          align="right"
          rowsPerPageOptions={rowsPerPageOptions.sort((a, b) => a - b).filter(onlyUnique)}
          colSpan={colSpan}
          count={count}
          rowsPerPage={pageSize}
          page={pageIndex}
          onPageChange={onChangePage}
          onRowsPerPageChange={onChangeRowsPerPage}
          ActionsComponent={TablePaginationActions}
        />
      </TableRow>
    </TableFooter>
  );
}