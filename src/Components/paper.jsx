import React from "react";
import makeStyles from '@mui/styles/makeStyles';
import Paper from "@mui/material/Paper";
import classNames from "classnames"
import { withComponentFeatures } from 'universal-dashboard';

const useStyles = makeStyles(theme => ({
  root: {
    flexGrow: 1,
    display: "flex",
    padding: theme.spacing(2),
    margin: theme.spacing()
  }
}));

const UdPaper = (props) => {

  const classes = useStyles();

  const {
    elevation,
    style,
    height,
    width,
    square
  } = props;

  return (
    <Paper
      id={props.id}
      className={classNames(classes.root, "ud-mu-paper", props.className)}
      elevation={elevation}
      style={{ ...style }}
      height={height}
      width={width}
      square={square}
    >
      {props.render(props.children)}
    </Paper>
  );
}

export default withComponentFeatures(UdPaper);
