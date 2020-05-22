/** @jsx jsx */
import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import Paper from "@material-ui/core/Paper";
import classNames from "classnames"
import {jsx} from 'theme-ui'
import { withComponentFeatures } from './universal-dashboard';

const useStyles = makeStyles(theme => ({
  root: {
    flexGrow: 1,
    display: "flex",
    padding: theme.spacing.unit * 2,
    margin: theme.spacing.unit
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
      className={classNames(classes.root, "ud-mu-paper")}
      elevation={elevation}
      style={{...style}}
      height={height}
      width={width}
      square={square}  
      //sx={{ bg: 'primary', color: 'text'}}
    >
      {props.render(props.children)}
    </Paper>
  );
}

export default withComponentFeatures(UdPaper);
