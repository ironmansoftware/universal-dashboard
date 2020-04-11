import React, { useState, useEffect } from "react";
import ErrorCard from "./error-card.jsx";
import ReactInterval from "react-interval";
import { withComponentFeatures } from "../universal-dashboard";
import Skeleton from "@material-ui/lab/Skeleton";

const UDPage = (props) => {
  document.title = props.name;

  const [components, setComponents] = useState([]);
  const [hasError, setHasError] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");

  const [components, setComponents] = useState([]);
  const [loading, setLoading] = useState(true);
  const [hasError, setHasError] = useState(false);
  const [errorMessage, setErrorMessage] = useState("");

  const loadData = () => {
    if (!props.match) {
      return;
    }

    var esc = encodeURIComponent;
    var query = Object.keys(queryParams)
      .map((k) => esc(k) + "=" + esc(queryParams[k]))
      .join("&");

    UniversalDashboard.get(
      `/api/internal/component/element/${props.id}?${query}`,
      (json) => {
        if (json.error) {
          setErrorMessage(json.error.message);
          setHasError(true);
        } else {
          setComponents(json.components);
          setHasError(false);
        }
      }
    );
  };

  var esc = encodeURIComponent;
  var query = Object.keys(queryParams)
    .map((k) => esc(k) + "=" + esc(queryParams[k]))
    .join("&");

  UniversalDashboard.get(
    `/api/internal/component/element/${props.id}?${query}`,
    (json) => {
      if (json.error) {
        setErrorMessage(json.error.message);
        setHasError(true);
      } else {
        setComponents(json);
        setHasError(false);
      }

      setLoading(false);
    }
  );
};

useEffect(() => {
  loadData();
  return () => {};
}, true);

if (hasError) {
  return (
    <ErrorCard
      message={errorMessage}
      id={props.id}
      title={"An error occurred on this page"}
    />
  );
}

if (loading) {
  if (props.onLoading) {
    return props.render(props.onLoading);
  }
  return [<Skeleton />, <Skeleton />, <Skeleton />];
}

var childComponents = props.render(components);

if (props.blank) {
  return [
    childComponents,
    <ReactInterval
      timeout={props.refreshInterval * 1000}
      enabled={props.autoRefresh}
      callback={loadData}
    />,
  ];
} else {
  return [
    props.render({
      type: "ud-navbar",
      pages: props.pages,
      title: props.name,
      history: props.history,
      id: "defaultNavbar",
    }),
    childComponents,
    <ReactInterval
      timeout={props.refreshInterval * 1000}
      enabled={props.autoRefresh}
      callback={loadData}
    />,
    // <UDFooter />
  ];
}

export default withComponentFeatures(UDPage);
