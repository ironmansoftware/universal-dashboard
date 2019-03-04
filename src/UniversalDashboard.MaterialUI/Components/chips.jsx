import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Avatar from '@material-ui/core/Avatar';
import Chip from '@material-ui/core/Chip';

const styles = theme => ({
  root: {
    display: 'flex',
    justifyContent: 'center',
    flexWrap: 'wrap',
  },
  chip: {
    margin: theme.spacing.unit,
  },
  chipIcon:{
    marginLeft: '3px',
    marginRight: '-8px'
  }
});



export class UdChip extends React.Component{

    handleDelete() {

        UniversalDashboard.publish('element-event', {
            type: "clientEvent",
            eventId: this.props.id + 'onDelete',
            eventName: '',
            eventData: ''
        });
    }
      
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

        var avatar = null
        if(this.props.avatar){

            switch (this.props.avatarType) {
                case "letter":
                    avatar = <Avatar>{this.props.avatar}</Avatar>
                    break;
                case "image":
                    avatar = <Avatar src={this.props.avatar}/>
                    break;
                default:
                    break;
            }
        }

        return(
            <Chip 
                id={this.props.id}
                avatar={avatar}
                label={this.props.label}
                clickable={this.props.clickable}
                onClick={this.handleClick}
                onDelete={this.props.delete ? this.handleDelete.bind(this) : null}
                className={classes.chip}
                color={this.props.color}
                icon={<div className={classes.chipIcon}>{UniversalDashboard.renderComponent(this.props.icon)}</div>}
                variant={this.props.chipStyle}
            />
        );
    }
}

UdChip.propTypes = {
    classes: PropTypes.object.isRequired,
  };
  
export default withStyles(styles)(UdChip)
