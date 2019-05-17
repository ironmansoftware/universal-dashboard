import React from 'react';
import {Select} from 'react-materialize';

export default class UDSelect extends React.Component {
    render() {
        return <Select 
            multiple={this.props.multiple} 
            id={this.props.id} 
            label={this.props.label}>

        </Select>
    }
}