import React from 'react';
import { WidthProvider, Responsive } from "react-grid-layout";
const ResponsiveReactGridLayout = WidthProvider(Responsive);

require('react-grid-layout/css/styles.css');
require('react-resizable/css/styles.css');

export default class UDGridLayout extends React.Component {

    constructor(props) {
        super(props);

        var layouts = this.props.layout.map(x => {
            x.i = "grid-element-" + x.i;
            return x;
        });
        if (this.props.persist) {
            var jsonLayouts = getFromLS("layouts");
            if (jsonLayouts != null) {
                layouts = JSON.parse(JSON.stringify(jsonLayouts))
            }
        };

        this.state = {
            layouts
        };
    }

    onLayoutChange(layout, layouts) {
        if (this.props.persist) {
            saveToLS("layouts", layouts);
            this.setState({ layouts });
        }
      }

    render() {

        var elements = this.props.content.map(x => 
                <div key={"grid-element-" + x.id}>
                    {UniversalDashboard.renderComponent(x)}
                </div>
            );

        return (
            <ResponsiveReactGridLayout className={this.props.className} layouts={this.state.layouts} cols={this.props.cols} rowHeight={this.props.rowHeight} onLayoutChange={(layout, layouts) =>
                this.onLayoutChange(layout, layouts)
              }>
                {elements}
            </ResponsiveReactGridLayout>
        )
    }
}

function getFromLS(key) {
    let ls = {};
    if (global.localStorage) {
      try {
        ls = JSON.parse(global.localStorage.getItem("rgl-8")) || {};
      } catch (e) {
        /*Ignore*/
      }
    }
    return ls[key];
  }
  
  function saveToLS(key, value) {
    if (global.localStorage) {
      global.localStorage.setItem(
        "rgl-8",
        JSON.stringify({
          [key]: value
        })
      );
    }
  }