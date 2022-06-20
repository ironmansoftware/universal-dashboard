import React from 'react';
import { MuiForm5 } from "@rjsf/material-ui";
import { withComponentFeatures } from 'universal-dashboard';

function SchemaForm(props) {
    return <MuiForm5 schema={props.schema} onSubmit={props.onSubmit} />
}

export default withComponentFeatures(SchemaForm);