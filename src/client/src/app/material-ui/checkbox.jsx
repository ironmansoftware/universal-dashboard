import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Checkbox from '@material-ui/core/Checkbox';
import FormControlLabel from '@material-ui/core/FormControlLabel'
import PubSub from 'pubsub-js';

const styles = theme => ({
});

export class UdCheckbox extends React.Component{

    constructor(props) {
        super(props);

        this.state = props;
    }

    componentWillReceiveProps(newProps) {
        if (this.props.checked !== newProps.checked) {
            this.setState({
                checked: newProps.checked
            })
        }
    }

    handleChange = (e, checked) => {

        this.setState({
            checked
        })

        if (this.props.onChange) {

            this.props.onChange(checked);
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

        var checkbox =  <Checkbox 
            checked={this.state.checked}
            color={this.props.color}
            disabled={this.props.disabled}  
            disableRipple={this.props.disableRipple}
            id={this.props.id}
            value="test"
            indeterminate={this.props.indeterminate}
            onChange={this.handleChange.bind(this)}
        />

        if (this.props.label) {
            checkbox = <FormControlLabel control={checkbox} label={this.props.label}></FormControlLabel>
        }
        
        return checkbox;
    }
}

UdCheckbox.propTypes = {
    classes: PropTypes.object.isRequired,
  };
  
export default withStyles(styles)(UdCheckbox);