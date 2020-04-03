/** @jsx jsx */
import React from "react";
import Paper from "@material-ui/core/Paper";
import classNames from "classnames"
import {jsx} from 'theme-ui'
import { withComponentFeatures } from './universal-dashboard';

const UdPaper = (props) => {
  const { 
    classes,
    elevation,
    style,
    height,
    width,
    square
  } = props;
  
  return (
    <Paper 
      id={props.id} 
      className={classNames("ud-mu-paper")}
      elevation={elevation}
      style={{...style}}
      height={height}
      width={width}
      square={square}  
      sx={{ bg: 'primary', color: 'text'}}
    >
      {props.render(props.children)}
    </Paper>
  );
}

export default withComponentFeatures(UdPaper);
