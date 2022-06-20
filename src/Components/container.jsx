import React from 'react';
import Container from '@mui/material/Container';
import { withComponentFeatures } from 'universal-dashboard'

const UDContainer = props => {
    return <Container className={props.className}>{props.render(props.children)}</Container>
}

export default withComponentFeatures(UDContainer)