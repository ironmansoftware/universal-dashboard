import React, { useState, useEffect } from 'react';
import { WidthProvider, Responsive } from "react-grid-layout";
import copy from 'copy-to-clipboard'

const ResponsiveReactGridLayout = WidthProvider(Responsive);
import { withComponentFeatures } from 'universal-dashboard'

require('react-grid-layout/css/styles.css');
require('react-resizable/css/styles.css');

const UDGridLayout = (props) => {

    const getFromLS = (key) => {
        let ls = {};
        if (global.localStorage) {
            try {
                ls = JSON.parse(global.localStorage.getItem(key)) || {};
            } catch (e) {
                /*Ignore*/
            }
        }
        return ls;
    }

    const saveToLS = (key, value) => {
        if (global.localStorage) {
            console.log("save");
            console.log(value);
            global.localStorage.setItem(
                key,
                JSON.stringify(value)
            );
        }
    }

    var defaultLayouts = []

    // Layout passed as props
    if (props.layout) {
        console.log('layout')
        defaultLayouts = JSON.parse(props.layout)

        if (!Array.isArray) {
            defaultLayouts = []
        } else {
            saveToLS("uddesign" + window.location.pathname, defaultLayouts)
        }
    }
    // Layout saved in local storage
    else if (props.persist) {
        var jsonLayouts = getFromLS("uddesign" + window.location.pathname);
        if (jsonLayouts != null) {
            defaultLayouts = JSON.parse(JSON.stringify(jsonLayouts))
        }
    }

    const [layouts, setLayouts] = useState(defaultLayouts);

    const onLayoutChange = (layout, layouts) => {
        if (props.persist) {
            saveToLS("uddesign" + window.location.pathname, layouts);
            setLayouts(layouts);
        }

        if (props.design) {
            copy(JSON.stringify(layouts))
        }
    }

    var children = props.children;
    if (!Array.isArray(children)) {
        children = [children];
    }

    var elements = children.map(x =>
        <div key={"grid-element-" + x.id}>
            {props.render(x)}
        </div>
    );

    return (
        <ResponsiveReactGridLayout
            layouts={layouts}
            cols={props.cols}
            rowHeight={props.rowHeight}
            onLayoutChange={onLayoutChange}
            measureBeforeMount={true}
            isDraggable={props.isDraggable || props.design}
            isResizable={props.isResizable || props.design}>
            {elements}
        </ResponsiveReactGridLayout>
    )
}

export default withComponentFeatures(UDGridLayout);