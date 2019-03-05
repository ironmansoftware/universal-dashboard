import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import IconButton from '@material-ui/core/IconButton';


const styles = theme => ({
  button: {
    margin: theme.spacing.unit,
  }
});

class UdIconButton extends React.Component {

  state = {
    anchorEl: null,
  }; 

  handleClick = () => {
    UniversalDashboard.publish('element-event', {
        type: "clientEvent",
        eventId: this.props.id + 'onClick',
        eventName: '',
        eventData: ''
    });
}

  render(){
    const { classes } = this.props;   

    return (
          <IconButton 
            onClick={this.handleClick.bind(this)} 
            className={classes.button}
            // color={this.props.color}
            disabled={this.props.disabled}
            id={this.props.id}
            style={{...this.props.style}}
          >
              {UniversalDashboard.renderComponent(this.props.icon)}
          </IconButton>
    );
  }
}

UdIconButton.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(UdIconButton);