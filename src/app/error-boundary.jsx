import { Alert, AlertTitle, Button, Snackbar } from "@mui/material";
import React from "react";
import copy from 'copy-to-clipboard'

export default class ErrorBoundary extends React.Component {
    constructor(props) {
        super(props);
        this.state = { hasError: false, error: null, errorInfo: null, snackbarOpen: false };
    }

    componentDidCatch(error, errorInfo) {
        this.setState({ hasError: true, error, errorInfo })
    }

    render() {
        const copyDetails = () => {
            copy(`Error rendering component (${this.props.componentType || 'unknown'})\r\n${this.state.error && this.state.error.toString()}\r\n${this.state.errorInfo.componentStack}`)
            this.setState({ snackbarOpen: true })
        }

        if (this.state.hasError) {
            return <>
                <Alert variant="standard" severity="error" style={{ margin: '5px' }}>
                    <AlertTitle>{`Error rendering component (${this.props.componentType || 'unknown'})`}</AlertTitle>
                    <p><strong>This error is not expected. Please report it to Ironman Software.</strong></p>
                    <Button onClick={copyDetails}>Copy Error Details</Button>
                </Alert>
                <Snackbar
                    open={this.state.snackbarOpen}
                    onClose={() => this.setState({ snackbarOpen: false })}
                    autoHideDuration={6000}
                    message="Error details copied"
                />
            </>
        }

        return this.props.children;
    }
}