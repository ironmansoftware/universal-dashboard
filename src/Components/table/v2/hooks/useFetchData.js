import React from "react";
import { MD5 } from "crypto-js";
import { generateColumns, normalizedData } from "../utilities";
import { useAsyncDebounce } from "react-table";

export default function useFetchData({ loadData }) {
  const [skipPageReset, setSkipPageReset] = React.useState(false);
  const [data, setData] = React.useState([]);
  const [pageCount, setPageCount] = React.useState(0);
  const [total, setTotal] = React.useState(0);
  const [loading, setLoading] = React.useState(false);

  const fetchData = React.useCallback(
    ({
      filters,
      pageSize,
      page,
      search,
      orderBy,
      orderDirection,
      properties,
    }) => {
      setSkipPageReset(true);
      setLoading(true);
      loadData({
        filters,
        pageSize,
        page,
        search,
        orderBy,
        orderDirection,
        properties,
      }).then((response) => {
        const result = JSON.parse(response);
        if (result?.length) {
          const [{ data, totalCount }] = result;
          const dataSource = normalizedData(data)?.map((entry) => ({
            ...entry,
            uid: MD5(JSON.stringify(entry)).toString(),
          }));

          setData(dataSource);
          setTotal(totalCount);
          setPageCount(Math.ceil(totalCount / pageSize));
          setSkipPageReset(false);
          setLoading(false);
        } else {
          setData([]);
          setTotal(0);
          setPageCount(0);
          setSkipPageReset(false);
          setLoading(false);
        }
      });
    },
    []
  );

  const onFetchDataDebounced = useAsyncDebounce(fetchData, 500);

  return {
    data: data,
    total: total,
    pageCount: pageCount,
    skipPageReset: skipPageReset,
    onFetchData: onFetchDataDebounced,
    loading: loading,
  };
}

//
// filters,
//         pageSize,
//         page: pageIndex,
//         search: globalFilter,
//         orderBy: { field: sortBy[0]?.id },
//         orderDirection: sortBy[0]?.desc ? "desc" : "asc",
//         properties: columns.map((column) => column.accessor),