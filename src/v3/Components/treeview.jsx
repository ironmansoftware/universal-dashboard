import React from 'react';

import { makeStyles } from '@material-ui/core/styles';
import TreeView from '@material-ui/lab/TreeView';
import ExpandMoreIcon from '@material-ui/icons/ExpandMore';
import ChevronRightIcon from '@material-ui/icons/ChevronRight';
import TreeItem from '@material-ui/lab/TreeItem';
import { withComponentFeatures } from 'universal-dashboard';

const useStyles = makeStyles({
  root: {
    flexGrow: 1,
    maxWidth: 400
  },
});

const UDTreeView = (props) => {
    const classes = useStyles();

    const onClick = (node) => {
        if (props.hasCallback) {
            props.notifyOfEvent('', node)
        }
    }

    const makeNodes = (nodes) => {
        var children = nodes;
        if (!Array.isArray(children))
        {
            children = [nodes];
        }

        return children.map(x => {
            if (!x) return <React.Fragment />

            return <TreeItem key={x.id} id={x.id} nodeId={x.id} label={x.name} onClick={() => onClick(x)}>
                {
                    Array.isArray(x.children) ? x.children.map(makeNodes) : makeNodes(x.children)  
                }
            </TreeItem>
        });
    }

    return (
        <TreeView
            className={classes.root}
            defaultCollapseIcon={<ExpandMoreIcon />}
            defaultExpandIcon={<ChevronRightIcon />}
            >
            {makeNodes(Array.isArray(props.node) ? props.node : [props.node])}
        </TreeView>
    )
}

export default withComponentFeatures(UDTreeView);