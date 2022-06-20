import React from 'react';
import PropTypes from 'prop-types';
import withStyles from '@mui/styles/withStyles';
import Avatar from '@mui/material/Avatar';
import classNames from 'classnames'

function UDMuAvatar(props) {

  const { classes } = props;
  
  return (
      <Avatar id={props.id} alt={props.alt} src={props.image} className={classNames(props.className, "ud-mu-avatar")}/>
  );
}

export default UDMuAvatar;
