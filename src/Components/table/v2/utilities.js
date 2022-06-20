import React from "react";
import {
  SelectColumnFilter,
  SliderColumnFilter,
  NumberRangeColumnFilter,
  DefaultColumnFilter,
  AutoCompleteColumnFilter,
  DateColumnFilter
} from "./filters";

import Papa from "papaparse";
import XLSX from "xlsx";
import JsPDF from "jspdf";
import "jspdf-autotable";
import { TableCell, TableRow } from "@mui/material";

export function normalizedData(dataSource) {

  if (!dataSource || dataSource.length === 0) return []
  const newDataArray = [];
  dataSource.map((data) => {
    const keys = Object.keys(data);
    let newData = {};
    keys.forEach((key) => {
      newData[key.toLowerCase()] = data[key];
    });
    newData["__version"] = 0;
    newDataArray.push(newData);
  });

  return newDataArray;
}

const psFilterNamesToRTFilterNames = {
  select: (rows, columnIds, filterValue) => rows.filter(row => row.values[columnIds[0]] != null && row.values[columnIds[0]].includes(filterValue)),
  slider: "equals",
  range: "between",
  text: "text",
  fuzzy: "search",
  date: "date"
};

const psFilterNamesToRTFilterFn = {
  select: SelectColumnFilter,
  slider: SliderColumnFilter,
  range: NumberRangeColumnFilter,
  text: DefaultColumnFilter,
  autocomplete: AutoCompleteColumnFilter,
  date: DateColumnFilter,
};

const getCellValue = (row, column) => {
  return `${row.values[column.id]}`
};

export function generateColumns(columnsData) {
  const columns = React.useMemo(
    () =>
      columnsData.map((column) => ({
        accessor: column?.field?.toLowerCase(), // column.field
        align: column?.align, // column.width
        cellRenderer: column?.render, // column.render
        disableExport: !column?.includeInExport, // column.export
        disableGlobalFilter: !column?.includeInSearch, // column.search
        Filter: psFilterNamesToRTFilterFn[column?.filterType],
        filter: psFilterNamesToRTFilterNames[column?.filterType],
        Header: column?.title, // column.title
        isDefaultSortColumn: column?.isDefaultSortColumn,
        maxWidth: column?.width, // column.width
        showFilter: column?.showFilter, // column.filter
        showSort: column?.showSort, // column.sort
        style: column?.style,
        width: column?.width, // column.width
        hidden: column?.hidden, // column.hidden
        getCellExportValue: getCellValue,
      })),
    []
  );

  return columns;
}

export function getExportFileBlob({ columns, data, fileType, fileName }) {
  if (fileType === "csv") {
    // CSV example
    const headerNames = columns.map((col) => col.exportValue);
    const csvString = Papa.unparse({ fields: headerNames, data });
    return new Blob([csvString], { type: "text/csv" });
  } else if (fileType === "xlsx") {
    const header = columns.map((c) => c.exportValue);
    const compatibleData = data.map((row) => {
      const obj = {};

      header.forEach((col, index) => {
        obj[col] = row[index];
      });
      return obj;
    });

    let wb = XLSX.utils.book_new();
    let ws1 = XLSX.utils.json_to_sheet(compatibleData, {
      header,
    });
    XLSX.utils.book_append_sheet(wb, ws1, "React Table Data");
    XLSX.writeFile(wb, `${fileName}.xlsx`);
    return false;
  }

  if (fileType === "pdf") {
    const headerNames = columns.map((column) => column.exportValue);
    const doc = new JsPDF();

    doc.autoTable({
      head: [headerNames],
      body: data,
      margin: { top: 20 },
      styles: {
        minCellHeight: 9,
        halign: "left",
        valign: "center",
        fontSize: 11,
      },
    });
    doc.save(`${fileName}.pdf`);

    return false;
  }

  if (fileType === "json") {
    const newJsonData = [];
    let newDataRow = {};
    const headerNames = columns.map((column) => column.exportValue);
    data.forEach((row) => {
      newDataRow = {};
      headerNames.forEach((header, index) => {
        if (Array.isArray(row)) {
          newDataRow[header] = row[index];
        }
        else {
          Object.keys(row).forEach((key) => {
            if (key.toLowerCase() === header.toLowerCase()) {
              newDataRow[header] = row[key];
            }
          });
        }
      });
      newJsonData.push(newDataRow);
    });

    let jsonString = JSON.stringify(newJsonData);
    return new Blob([jsonString], {
      type: "application/json;charset=utf-8;",
    });
  }
  return false;
}

export function setCellPadding(id, index) {
  return id === "selection"
    ? "checkbox"
    : id !== "selection" && index === 1
      ? "none"
      : "default";
}

export function onlyUnique(value, index, self) {
  return self.indexOf(value) === index;
}

export function setEmptyRows({ totalData, pageSize, pageIndex, visibleColumns, isDense }) {
  const pSize = totalData < pageSize ? totalData : pageSize;
  const emptyRows = pSize - Math.min(pSize, totalData - pageIndex * pSize);

  return (
    emptyRows > 0 && (
      <TableRow style={{ height: (isDense ? 33 : 53) * emptyRows }}>
        <TableCell colSpan={visibleColumns.length} />
      </TableRow>
    )
  );
}

export function format(fmt, ...args) {
  if (!fmt.match(/^(?:(?:(?:[^{}]|(?:\{\{)|(?:\}\}))+)|(?:\{[0-9]+\}))+$/)) {
    throw new Error('invalid format string.');
  }
  return fmt.replace(/((?:[^{}]|(?:\{\{)|(?:\}\}))+)|(?:\{([0-9]+)\})/g, (m, str, index) => {
    if (str) {
      return str.replace(/(?:{{)|(?:}})/g, m => m[0]);
    } else {
      if (index >= args.length) {
        throw new Error('argument index is out of range in format');
      }
      return args[index];
    }
  });
}

export function downloadFileViaBlob(fileBlob, fileName, type) {
  if (fileBlob) {
    const dataUrl = URL.createObjectURL(fileBlob);
    const link = document.createElement("a");
    link.download = `${fileName}.${type}`;
    link.href = dataUrl;
    link.click();
  }
}