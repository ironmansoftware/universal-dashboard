import React,{Suspense} from 'react';
import UdIcon from './ud-icon.jsx';
const UdTerminal = React.lazy(() => import( './ud-terminal.jsx' /* webpackChunkName: "ud-terminal" */))

export default class UDDesigner extends React.Component {

    constructor() {
        super();

        this.state = {
            open : false
        }
    }

    componentDidMount() {
        if (window.jQuery) {
            $(this.modal).modal();
        }
    }

    toggleTerminal() {
        if (window.jQuery) {
            $(this.modal).modal(this.state.open ? 'close' : 'open');
        }
    }

    render() {
        return (
            [
                <div className="fixed-action-btn">
                    <a className="btn-floating btn-large red" onClick={this.toggleTerminal.bind(this)} id='btnDesignTerminal'>
                        <i className="large fa fa-terminal"></i>
                    </a>
                </div>,
                <div ref={modal => this.modal = modal} className="modal bottom-sheet">
                    <div className="modal-content">
                        <h4><UdIcon icon={'terminal'}/>  Design Terminal</h4>
                        <Suspense fallback={<div/>}><UdTerminal /> </Suspense>
                    </div>
                </div>
            ]
        )
    }
}