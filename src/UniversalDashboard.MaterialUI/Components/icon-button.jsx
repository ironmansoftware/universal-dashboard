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

  onClickEvent = () => {
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
            onClick={this.onClickEvent} 
            className='ud-icon-button'
            disabled={this.props.disabled}
            id={this.props.id}
            style={{...this.props.style}}
            href={this.props.href}
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