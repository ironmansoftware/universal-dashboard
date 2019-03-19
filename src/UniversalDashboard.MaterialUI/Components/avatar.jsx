import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Avatar from '@material-ui/core/Avatar';
import classNames from 'classnames'

const styles = {
  avatar: {
    margin: 10,
  },
};

function UDMuAvatar(props) {

  const { classes } = props;
  
  return (
      <Avatar id={props.id} alt={props.alt} src={props.image} className={classNames(props.className,classes.avatar, "ud-mu-avatar")} style={{...props. style}}/>
  );
}

UDMuAvatar.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(UDMuAvatar);
