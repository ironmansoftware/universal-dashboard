import { useState } from "react";
import * as JsSearch from "js-search";

export function appSearch(key, fields, data, term) {
  if (data === undefined) return;

  let uniqeKey = typeof key === "number" ? key.toString() : key;
  const search = new JsSearch.Search(uniqeKey);
  search.searchIndex = new JsSearch.UnorderedSearchIndex();
  search.indexStrategy = new JsSearch.AllSubstringsIndexStrategy();

  let fieldset = [];
  if (!Array.isArray(fields)) {
    fieldset.push(fields);
  }
  if (Array.isArray(fields)) {
    fieldset = fields;
  }
  fieldset.forEach((field) => search.addIndex(field));

  search.addDocuments(Array.isArray(data) ? data : [data]);

  return search.search(term);
}

export function useSearch(key, fields, data) {
  const [values, setFilterValue] = useState(data);

  function search(value) {
    if (value === undefined || value === "") {
      setFilterValue(data);
    } else {
      let results = appSearch(key, fields, data, value);
      setFilterValue(results);
    }
  }

  return { values, search };
}

function objectToCsv(data) {
  const csvRows = [];
  const headers = Object.keys(data[0]);
  csvRows.push(headers.join(","));

  for (const row of data) {
    const values = headers.map((header) => {
      const escaped = ("" + row[header]).replace(/"/g, '\\"');
      return `"${escaped}"`;
    });
    csvRows.push(values.join(","));
  }

  return csvRows.join("\n");
}

export function downloadCSV(data, csvName = "Table") {
  let csvString = objectToCsv(data)
  var blob = new Blob([csvString], { type: "text/csv;charset=utf-8;" });
  var blobURL = window.URL.createObjectURL(blob);
  var link = document.createElement("a");
  link.setAttribute("href", blobURL);
  link.setAttribute("download", csvName + ".csv");
  link.setAttribute("tabindex", "0");
  link.innerHTML = "";
  document.body.appendChild(link);
  link.click();
}

export function downloadJson(data, jsonName = "Table") {
  let jsonString = JSON.stringify(data)
  var blob = new Blob([jsonString], { type: "application/json;charset=utf-8;" });
  var blobURL = window.URL.createObjectURL(blob);
  var link = document.createElement("a");
  link.setAttribute("href", blobURL);
  link.setAttribute("download", jsonName + ".json");
  link.setAttribute("tabindex", "0");
  link.innerHTML = "";
  document.body.appendChild(link);
  link.click();
}
