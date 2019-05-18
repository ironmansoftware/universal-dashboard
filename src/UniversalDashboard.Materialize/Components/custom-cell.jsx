import React from 'react';
import moment from 'moment';

export default class CustomCell extends React.Component {
    render() {
        const validComponents = ["link", "icon", "image", "element"]
        
        var y = this.props.value;
        var moment2 = moment(y);

        if (y == null) {
            return <span></span>;
        }        
        if (y.DateTime) {
            moment2 = moment(y.value);
            if (moment2.isValid) {
                return <span>{moment2.format(this.props.dateTimeFormat)}</span>;
            }
            else {
                return <span>{y.DateTime}</span>;
            }
        }
        else if (y.match  && y.match(/^(\d{4})-(\d{1,2})-(\d{1,2})T/) != null) {
            var moment2 = moment(y);
            if (moment2.isValid) {
                return <span>{moment2.format(this.props.dateTimeFormat)}</span>;
            }
        }
        else if (y.startsWith && y.startsWith("/Date(")){
            moment2 = moment(y.substr(6), 'x)/"');
            if (moment2.isValid) {
                return <span>{moment2.format(this.props.dateTimeFormat)}</span>;
            }
        } else if (y.type && validComponents.indexOf(y.type) !== -1) {
            y.preventUnregister = true;
            return UniversalDashboard.renderComponent(y);
        }
        else if (y.type) {
            y.preventUnregister = true;
            return UniversalDashboard.renderComponent(y);
        }else if (typeof(y) === "boolean"){            
            y = y.toString();
        }

        return <span>{y}</span>;
    }
}