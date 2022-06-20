import React from 'react';
import { Badge } from '@mui/material';
import { withComponentFeatures } from 'universal-dashboard';

const UDBadge = (props) => {
    return <Badge
        {...props}
        badgeContent={Number.isNaN(props.badgeContent) ? props.render(props.badgeContent) : props.badgeContent}
        anchorOrigin={{
            vertical: props.location.indexOf('bottom') !== -1 ? 'bottom' : 'top',
            horizontal: props.location.indexOf('left') !== -1 ? 'left' : 'right'
        }}
    >
        {props.render(props.children)}
    </Badge>
}

export default withComponentFeatures(UDBadge);