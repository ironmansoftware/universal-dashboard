import React from "react";
import { withComponentFeatures } from "universal-dashboard";
import { ErrorBoundary } from "react-error-boundary";
import AlertCard from "./Alert";
import TableBase from "./baseTable";
import { generateColumns } from "./utilities";

const Table = ({ data, columns, ...restOfProps }) => {
  const cols = React.useMemo(() => generateColumns(columns), [restOfProps]);
  const isServerSide = restOfProps.loadData ? true : false;
  const sortColumn = cols.find(col => col.isDefaultSortColumn)?.accessor || ""

  return (
    <ErrorBoundary FallbackComponent={AlertCard}>
      <TableBase
        {...restOfProps}
        data={data}
        columns={cols}
        sortColumn={sortColumn}
        isServerSide={isServerSide}
      // getCellProps={cellInfo => ({
      //   style: {
      //     backgroundColor: cellInfo.value === "Stopped" ? "red" : cellInfo.value === "Running" ? "green" : "unset",
      //     color: cellInfo.value === "Stopped" ? "#fff" : cellInfo.value === "Running" ? "#fff" : "unset"
      //   },
      // })}
      />
    </ErrorBoundary>
  );
};

export default withComponentFeatures(Table);