import React from "react";
import classNames from "classnames"
import makeStyles from '@mui/styles/makeStyles';
import { CardMedia } from "@mui/material";

const useStyles = makeStyles(theme => ({
  media: {
    objectFit: "cover",
    backgroundColor: "transparent"
    // height: "100%"
  }
}));


const UDCardMedia = (props) => {
  const classes = useStyles();
  const { component, alt, height, image, title, source } = props;

  return (
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
  );
}

export default UDCardMedia;
