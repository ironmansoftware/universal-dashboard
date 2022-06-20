import React from 'react';
import { Skeleton } from '@mui/material';
import { withComponentFeatures } from 'universal-dashboard';

function UDSkeleton(props) {

    var animation = null;
    if (props.animation === "disabled") {
        animation = false;
    }

    if (props.animation === "wave") {
        animation = 'wave';
    }

    return <Skeleton
        id={props.id}
        className={props.className}
        variant={props.variant}
        height={props.height == 0 ? null : props.height}
        width={props.width == 0 ? null : props.width}
        animation={animation} />
}

export default withComponentFeatures(UDSkeleton);