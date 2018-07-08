import React from 'react';

export default class TextSize extends React.Component {
    render() {
        if (this.props.size == "Small") {
            return this.props.children;
        }

        if (this.props.size == "Medium") {
            return <h5>{this.props.children}</h5>;
        }

        if (this.props.size == "Large") {
            return <h3>{this.props.children}</h3>;
        }
    }
}