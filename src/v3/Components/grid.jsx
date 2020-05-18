import React from 'react';
import Grid from '@material-ui/core/Grid';

const UDGrid = (props) => {
    return (
        <Grid {...props} key={props.id}>
            { props.children && UniversalDashboard.renderComponent(props.children)}
        </Grid>
    )
}

export default UDGrid;