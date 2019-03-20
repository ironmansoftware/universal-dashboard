import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import IconButton from '@material-ui/core/IconButton';
import classNames from "classnames"


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
    const { classes, className,disabled,id,style,href,icon } = this.props;   

    return (
          <IconButton 
            onClick={this.onClickEvent} 
            className={classNames(className, 'ud-mu-iconbutton')}
            disabled={disabled}
            id={id}
            style={{...style}}
            href={href}
          >
              {UniversalDashboard.renderComponent(icon)}
          </IconButton>
    );
  }
}

UdIconButton.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(UdIconButton);