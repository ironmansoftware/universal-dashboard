import React from 'react';
import Container from '@material-ui/core/Container';
import { withComponentFeatures } from './universal-dashboard'

const UDContainer = props => {
    return <Container>{props.render(props.children)}</Container>
}

export default withComponentFeatures(UDContainer)