import React from 'react';
import UdIcon from './ud-icon.jsx';
import UdTerminal from './ud-terminal';
import M from 'materialize-css';

export default class UDDesigner extends React.Component {

    constructor() {
        super();

        this.state = {
            open : false
        }
    }

    componentDidMount() {
        this.modalInstance = M.Modal.init(this.modal);
    }

    componentWillUnmount() {
        this.modalInstance.destroy();
    }

    toggleTerminal() {
        if (this.state.open) {
            this.modalInstance.close();
        } else {
            this.modalInstance.open();
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
                        <UdTerminal />
                    </div>
                </div>
            ]
        )
    }
}