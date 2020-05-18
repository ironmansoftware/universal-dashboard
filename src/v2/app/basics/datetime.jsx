import React from 'react';
import moment from 'moment';

export default class DateTime extends React.Component {
    render() {
        var y = this.props.value;

        var moment2 = moment(y);
        if (moment2.isValid) {
            return <span>{moment2.format(this.props.dateTimeFormat)}</span>;
        }

        return <span>{y}</span>;
    }
}