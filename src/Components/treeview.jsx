import React from 'react';

import makeStyles from '@mui/styles/makeStyles';
import TreeView from '@mui/lab/TreeView';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';
import TreeItem from '@mui/lab/TreeItem';
import { withComponentFeatures } from 'universal-dashboard';
var classNames = require('classnames');

const useStyles = makeStyles({
    root: {
        flexGrow: 1,
        maxWidth: 400
    },
});

const UDTreeView = (props) => {
    const classes = useStyles();

    const onClick = (event, node) => {
        if (node.leaf) {
            event.preventDefault();
        }

        if (props.onNodeClicked) {
            props.onNodeClicked(node).then(x => {
                var children = x;
                node.children = JSON.parse(children);
                props.setState({ nodes: props.nodes })
            });
        }
    }

    const makeNodes = (nodes) => {
        var children = nodes;
        if (!Array.isArray(children)) {
            children = [nodes];
        }

        return children.map(x => {
            if (!x) return <React.Fragment />

            let children = null;
            if (!x.leaf) {
                children = Array.isArray(x.children) ? x.children.map(makeNodes) : makeNodes(x.children);
            }

            return <TreeItem
                key={x.id}
                id={x.id}
                nodeId={x.id}
                label={x.name}
                onIconClick={(e) => onClick(e, x)}
                onLabelClick={(e) => onClick(e, x)}
                collapseIcon={x.expandedIcon && props.render(x.expandedIcon)}
                expandIcon={x.icon && props.render(x.icon)}
                children={children}
            />
        });
    }

    return (
        <TreeView
            id={props.id}
            className={classNames(classes.root, props.className)}
            style={props.style}
            defaultCollapseIcon={<ExpandMoreIcon />}
            defaultExpandIcon={<ChevronRightIcon />}
        >
            {makeNodes(Array.isArray(props.node) ? props.node : [props.node])}
        </TreeView>
    )
}

export default withComponentFeatures(UDTreeView);