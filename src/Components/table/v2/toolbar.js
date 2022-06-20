import React from "react";
import { alpha } from "@mui/material/styles";
import makeStyles from '@mui/styles/makeStyles';
import Toolbar from "@mui/material/Toolbar";
import Typography from "@mui/material/Typography";
import IconButton from "@mui/material/IconButton";
import RefreshIcon from "@mui/icons-material/Refresh";

import { TablePagination, LinearProgress } from "@mui/material";
import ExportButton from "../exportButton";
import GlobalFilter from "./globalFilter";
import TablePaginationActions from "../v2/TablePaginationActions";
import { onlyUnique } from "../v2/utilities";

const useStyles = makeStyles((theme) => ({
  grow: {
    flexGrow: 1,
  },
  menuButton: {
    marginRight: theme.spacing(2),
  },
  title: {
    display: "none",
    [theme.breakpoints.up("sm")]: {
      display: "block",
    },
  },
  actions: {
    display: "flex",
    justifyContent: "space-between",
    width: "100%",
    // backgroundColor: '#141414'
  },
  actionsRight: {
    display: "inline-flex",
    alignItems: "center",
  },
  search: {
    position: "relative",
    borderRadius: theme.shape.borderRadius,
    backgroundColor: alpha(theme.palette.common.white, 0.15),
    "&:hover": {
      backgroundColor: alpha(theme.palette.common.white, 0.25),
    },
    marginRight: theme.spacing(2),
    marginLeft: 0,
    width: "100%",
    [theme.breakpoints.up("sm")]: {
      marginLeft: theme.spacing(3),
      width: "auto",
    },
  },
  searchIcon: {
    padding: theme.spacing(0, 2),
    height: "100%",
    position: "absolute",
    pointerEvents: "none",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
  },
  inputRoot: {
    color: "inherit",
  },
  inputInput: {
    padding: theme.spacing(1, 1, 1, 0),
    // vertical padding + font size from searchIcon
    paddingLeft: `calc(1em + ${theme.spacing(4)})`,
    transition: theme.transitions.create("width"),
    width: "100%",
    [theme.breakpoints.up("md")]: {
      width: "20ch",
    },
  },
  sectionDesktop: {
    display: "none",
    [theme.breakpoints.up("md")]: {
      display: "flex",
    },
  },
  sectionMobile: {
    display: "flex",
    [theme.breakpoints.up("md")]: {
      display: "none",
    },
  },
}));

export default function TableToolbar({
  title,
  count,
  isVisible,
  showExport,
  showSearch,
  showRefresh,
  refresh,
  exportData,
  exportFileName,
  setExportFileName,
  preGlobalFilteredRows,
  setGlobalFilter,
  globalFilter,
  textOption,
  exportOption,
  icon,
  userPageSize,
  userPageSizeOptions,
  colSpan,
  pageIndex,
  gotoPage,
  setPageSize,
  pageSize,
  isPaginationVisible,
  loading,
  disablePageSizeAll,
  toolbarContent
}) {
  const classes = useStyles();
  const render = UniversalDashboard.renderComponent;

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

  return isVisible && (
    <div className={classes.grow}>
      <Toolbar className={classes.actions}>
        <Typography className={classes.title} variant="h5" noWrap>
          {
            icon && (
              render(icon)
            )
          }
          {title}
        </Typography>
        <div className={classes.actionsRight}>
          {showSearch && (
            <GlobalFilter
              preGlobalFilteredRows={preGlobalFilteredRows}
              globalFilter={globalFilter}
              count={count}
              setGlobalFilter={setGlobalFilter}
              textOption={textOption}
            />
          )}
          {render(toolbarContent)}
          {showRefresh && (
            <IconButton aria-controls='refresh' disabled={loading} onClick={refresh} size="large">
              <RefreshIcon />
            </IconButton>
          )}
          {showExport && (
            <ExportButton
              exportData={exportData}
              exportFileName={exportFileName}
              setExportFileName={setExportFileName}
              textOption={textOption}
              exportOption={exportOption}
            />
          )}
          {isPaginationVisible && (<div style={{ float: 'right' }}>
            {loading ? <LinearProgress style={{ marginTop: '20px', marginLeft: '10px' }} /> : <React.Fragment />}
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
          </div>)}
        </div>
      </Toolbar>

    </div>
  );
}