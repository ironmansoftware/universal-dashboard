import React from 'react';
import PropTypes from 'prop-types';
import IconButton from '@mui/material/IconButton';
import classNames from "classnames"
import { withComponentFeatures } from 'universal-dashboard'
import makeStyles from '@mui/styles/makeStyles';
import UdMuIcon from './icon'

const useStyles = makeStyles(theme => ({
  button: {
    margin: theme.spacing(),
  },
}))

const UdIconButton = props => {
  const { className, disabled, id, style, href, icon, onClick } = props;
  const classes = useStyles();

  const handleClick = () => {
    if (onClick == null) return
    onClick();
  }

  return (
    <IconButton
      onClick={handleClick}
      className={classNames(classes.button, 'ud-mu-iconbutton', className)}
      disabled={disabled}
      id={id}
      style={{ ...style }}
      href={href}
      size="large">
      <UdMuIcon {...icon} />
    </IconButton>
  );
}

export default withComponentFeatures(UdIconButton);