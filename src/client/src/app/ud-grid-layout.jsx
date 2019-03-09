import React from 'react';
import { WidthProvider, Responsive } from "react-grid-layout";
const ResponsiveReactGridLayout = WidthProvider(Responsive);

require('react-grid-layout/css/styles.css');
require('react-resizable/css/styles.css');

export default class UDGridLayout extends React.Component {
    render() {

        var elements = this.props.content.map(x => 
                <div key={x.id}>
                    {UniversalDashboard.renderComponent(x)}
                </div>
            );

        return (
            <ResponsiveReactGridLayout className={this.props.className} layout={this.props.layout} cols={this.props.cols} rowHeight={this.props.rowHeight}>
                {elements}
            </ResponsiveReactGridLayout>
        )
    }
}