import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Avatar from '@material-ui/core/Avatar';
import Chip from '@material-ui/core/Chip';
import Icon from '@material-ui/core/Icon';
import PubSub from 'pubsub-js';

const styles = theme => ({
  root: {
    display: 'flex',
    justifyContent: 'center',
    flexWrap: 'wrap',
  },
  chip: {
    margin: theme.spacing.unit,
  },
});



export class UdChip extends React.Component{
    handleDelete = () => {

        PubSub.publish('element-event', {
            type: "clientEvent",
            eventId: this.props.id + 'onDelete',
            eventName: '',
            eventData: ''
        });
    }
      
    handleClick = () => {

        if (this.props.onClick) {

            var state = {}
            state[this.props.onClick] = true;
            this.props.dispatchState(state);
        } else {
            PubSub.publish('element-event', {
                type: "clientEvent",
                eventId: this.props.id + 'onClick',
                eventName: '',
                eventData: ''
            });
        }
    }

    render(){
        const { classes } = this.props;

        var icon = null
        if(this.props.icon !== 'None'){
            icon = <Icon fontSize='default' className={`fa fa-${this.props.icon}`} />
        }

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
                avatar={avatar}
                label={this.props.label}
                clickable={this.props.clickable}
                onClick={this.props.clickable ? this.handleClick : null}
                onDelete={this.props.delete ? this.handleDelete : null}
                className={classes.chip}
                color={this.props.color}
                icon={this.props.icon !== 'None' ? icon : null}
                variant={this.props.chipStyle}
            />
        );
    }
}

UdChip.propTypes = {
    classes: PropTypes.object.isRequired,
  };
  
export default withStyles(styles)(UdChip);
