import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Badge from '@material-ui/core/Badge';
import IconButton from '@material-ui/core/IconButton';


const styles = theme => ({
  button: {
    margin: theme.spacing.unit,
  }
});

class UdIconButton extends React.Component {

  state = {
    anchorEl: null,
    ...this.props
  }; 

  handleClick = (props) => {
    UniversalDashboard.publish('element-event', {
        type: "clientEvent",
        eventId: props.id + 'onClick',
        eventName: '',
        eventData: ''
    });
}

  render(){
    const { classes } = this.props;   

    var icon = null
    if(this.props.badge){
        icon = <Badge badgeContent={this.props.badgeContent} color={this.props.badgeColor} invisible={false}>
            {UniversalDashboard.renderComponent(this.props.icon)}
        </Badge>
    }
    else{
      icon =  UniversalDashboard.renderComponent(this.props.icon)
    }

    return (
        <div>
          <IconButton 
            onClick={this.props.clickable ? this.handleClick.bind(this, this.props) : null} 
            className={classes.button}
            color={this.props.color}
            disabled={this.props.disabled}
            id={this.props.id}
          >
              {icon}
          </IconButton>
        </div>
    );
  }
}

UdIconButton.propTypes = {
  classes: PropTypes.object.isRequired,
};

export default withStyles(styles)(UdIconButton);