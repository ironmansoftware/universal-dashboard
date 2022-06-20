import React from 'react';
import { Stack } from '@mui/material';
import { withComponentFeatures } from 'universal-dashboard';

function UDStack(props) {

    const children = props.render(props.children);
    let divider = null;
    if (props.divider) {
        divider = props.render(props.divider)
    }

    return <Stack {...props} divider={divider}>{children}</Stack>
}

export default withComponentFeatures(UDStack);