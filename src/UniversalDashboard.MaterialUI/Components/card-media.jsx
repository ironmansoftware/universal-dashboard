import React from "react";
import classNames from "classnames"
import { CardMedia, withStyles } from "@material-ui/core";

const UDCardMedia = withStyles(theme => ({
  media: {
    objectFit: "cover",
    backgroundColor: "transparent"
    // height: "100%"
  }
}))(props => {
  const {
    classes,
    component,
    alt,
    height,
    image,
    title,
    source,
    children
  } = props;
  return (
    <>
      <CardMedia
        className={classNames(classes.media, "ud-mu-cardmedia")}
        component={component}
        alt={alt}
        height={height}
        image={image}
        title={title}
        src={source}
        controls={component === ("video" || "audio") ? true : false}
      />
      {children}
    </>
  );
});

export default UDCardMedia;
