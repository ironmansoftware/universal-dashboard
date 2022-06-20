import React from 'react';

export default class UdHtml extends React.Component {
    render() {
        return <div dangerouslySetInnerHTML={{__html: this.props.markup}} />
    }
}