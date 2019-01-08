import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import PubSub from 'pubsub-js';

const styles = theme => ({
});

export class UdTextField extends React.Component{
    handleBlur = (e) => {

        if (this.props.onBlur) {
            this.props.onBlur(e.target.value)
        } else {
            PubSub.publish('element-event', {
                type: "clientEvent",
                eventId: this.props.id + 'onBlur',
                eventName: '',
                eventData: ''
            });
        }
    }
      
    handleChange = (e) => {

        if (this.props.onChange) {
            this.props.onChange(e.target.value);
        } else {
            // PubSub.publish('element-event', {
            //     type: "clientEvent",
            //     eventId: this.props.id + 'onClick',
            //     eventName: '',
            //     eventData: ''
            // });
        }
    }

    render(){
        const { classes } = this.props;

        return(
            <TextField 
                autoFocus={this.props.autoFocus}
                defaultValue={this.props.defaultValue}
                disabled={this.props.disabled}
                error={this.props.error}
                fullWidth={this.props.fullWidth}
                helperText={this.props.helperText}
                id={this.props.id}
                multiline={this.props.multiline}
                name={this.props.name}
                placeholder={this.props.placeholder}
                required={this.props.required}
                rows={this.props.rows}
                rowsMax={this.props.rowsMax}
                type={this.props.type}
                value={this.props.value}
                variant={this.props.variant}
                onBlur={this.handleBlur.bind(this)}
                onChange={this.handleChange.bind(this)}
            />
        );
    }
}

UdTextField.propTypes = {
    classes: PropTypes.object.isRequired,
  };
  
export default withStyles(styles)(UdTextField);