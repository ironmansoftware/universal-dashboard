import React from 'react';
import UdIcon from './ud-icon.jsx';
import UdTerminal from './ud-terminal';
import M from 'materialize-css';
import * as clipboard from "clipboard-polyfill"

export default class UDDesigner extends React.Component {

    constructor() {
        super();

        this.state = {
            open : false
        }
    }

    componentDidMount() {
        this.modalInstance = M.Modal.init(this.modal);

        var elems = document.querySelectorAll('.fixed-action-btn');
        this.fabInstance = M.FloatingActionButton.init(elems);
    }

    componentWillUnmount() {
        this.modalInstance.destroy();
        this.fabInstance.destroy();
    }
    
    toggleTerminal() {
        if (this.state.open) {
            this.modalInstance.close();
        } else {
            this.modalInstance.open();
        }
    }

    getFromLS(key) {
        let ls = {};
        if (global.localStorage) {
            try {
            ls = JSON.parse(global.localStorage.getItem("rgl-8")) || {};
            } catch (e) {
            /*Ignore*/
            }
        }
        return ls[key];
    }
  
    copyLayout() {

        var layout = this.getFromLS("uddesign");
        
        if (layout == null || layout.lg == null) {
            M.toast({html: "No layout saved. Make sure you are using New-UDGridLayout."});
        } 

        layout.lg.forEach(x => {
            x.static = true
        });

        var stringLayout = JSON.stringify(layout);

        clipboard.writeText(stringLayout).then(x => {
            M.toast({ html: "Layout copied to clipboard!"});
        });
    }

    render() {
        return (
            [
                <div className="fixed-action-btn">
                    <a className="btn-floating btn-large red">
                        <UdIcon icon="Edit" />
                    </a>
                    <ul>
                        <li><a className="btn-floating green" title="Copy Layout" onClick={this.copyLayout.bind(this)}><UdIcon icon="Copy" /></a></li>                        
                        <li><a className="btn-floating blue" onClick={this.toggleTerminal.bind(this)} id='btnDesignTerminal' title="Open Design Terminal"><UdIcon icon="Terminal" /></a></li>                        
                    </ul>
                </div>,
                <div ref={modal => this.modal = modal} className="modal bottom-sheet">
                    <div className="modal-content">
                        <h4><UdIcon icon={'Terminal'}/>  Design Terminal</h4>
                        <UdTerminal />
                    </div>
                </div>
            ]
        )
    }
}