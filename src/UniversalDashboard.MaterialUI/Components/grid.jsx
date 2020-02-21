import React from 'react';
import Grid from '@material-ui/core/Grid';

const UDGrid = (props) => {
    return (
        <Grid {...props} key={props.id}>
            { props.content && UniversalDashboard.renderComponent(props.content)}
        </Grid>
    )
}

export default UDGrid;