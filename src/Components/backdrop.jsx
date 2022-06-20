import React from 'react';
import { Backdrop } from '@mui/material';
import { withComponentFeatures } from 'universal-dashboard';
import makeStyles from '@mui/styles/makeStyles';

const useStyles = makeStyles((theme) => ({
  backdrop: props => ({
    zIndex: theme.zIndex.drawer + 1,
    color: props.color,
  }),
}));


function UDBackdrop(props) {
  const classes = useStyles(props);

  return <Backdrop id={props.id} open={props.open} className={classes.backdrop} onClick={() => props.onClick()}>{props.render(props.children)}</Backdrop>
}

export default withComponentFeatures(UDBackdrop);