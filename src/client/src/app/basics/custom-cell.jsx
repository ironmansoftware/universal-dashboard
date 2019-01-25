import React from 'react';
import moment from 'moment';
import renderComponent from './../services/render-service.jsx';

export default class CustomCell extends React.Component {
    render() {
        const validComponents = ["link", "icon", "image", "element"]
        
        var y = this.props.value;

        if (y == null) {
            return <span></span>;
        }        
        if (y.DateTime) {
            var moment2 = moment(y.value);
            if (moment2.isValid) {
                return <span>{moment2.format(this.props.dateTimeFormat)}</span>;
            }
            else {
                return <span>{y.DateTime}</span>;
            }
        }
        else if (y.startsWith && y.startsWith("/Date(")){
            var moment2 = moment(y.substr(6), 'x)/"');
            if (moment2.isValid) {
                return <span>{moment2.format(this.props.dateTimeFormat)}</span>;
            }
        } else if (y.type && validComponents.indexOf(y.type) !== -1) {
            y.preventUnregister = true;
            return renderComponent(y);
        }
        else if (y.type) {
            y.preventUnregister = true;
            return renderComponent(y);
        }else if (typeof(y) === "boolean"){            
            y = y.toString();
        }

        return <span>{y}</span>;
    }
}