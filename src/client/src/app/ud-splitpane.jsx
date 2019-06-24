import React from 'react';
import SplitPane from 'react-split-pane';

export default class UDSplitPane extends React.Component {
    render() {
        var { content } = this.props;
        
        if (content.length !== 2) {
            throw "Split pane supports exactly two components."
        }

        var children = this.content.map(x => UniversalDashboard.renderComponent(x));

        return <SplitPane {...props}>{children}</SplitPane>
    }
}