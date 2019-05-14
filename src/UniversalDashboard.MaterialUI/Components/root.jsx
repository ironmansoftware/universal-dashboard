import React from 'react';
import { ThemeProvider } from '@material-ui/styles';
import { createMuiTheme } from '@material-ui/core';

export default class Root extends React.Component {
    render() {

        var defaultTheme = createMuiTheme({});

        return <ThemeProvider theme={defaultTheme}>
                    {this.props.children}
            </ThemeProvider>
    }
}