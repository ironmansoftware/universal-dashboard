import React from 'react';
import { Collapse, Slide, Zoom, Grow, Fade } from '@mui/material';
import { withComponentFeatures } from 'universal-dashboard';

class TransitionWrapper extends React.Component {
    render() {
        return this.props.children;
    }
}

function Transition(props) {
    if (props.transition === "fade") {
        return <Fade timeout={props.timeout} in={props.in}>
            <span>{props.render(props.children)}</span>
        </Fade>
    }

    if (props.transition === "zoom") {
        return <Zoom timeout={props.timeout} in={props.in}>
            <span>{props.render(props.children)}</span>
        </Zoom>
    }

    if (props.transition === "grow") {
        return <Grow timeout={props.timeout} in={props.in}>
            <span>{props.render(props.children)}</span>
        </Grow>
    }

    if (props.transition === "slide") {
        return <Slide timeout={props.timeout} in={props.in} direction={props.slideDirection}>
            <span>{props.render(props.children)}</span>
        </Slide>
    }

    if (props.transition === "collapse") {
        return (
            <Collapse timeout={props.timeout} in={props.in} collapsedSize={props.collapsedHeight}>
                <span>{props.render(props.children)}</span>
            </Collapse>
        );
    }
}

export default withComponentFeatures(Transition);