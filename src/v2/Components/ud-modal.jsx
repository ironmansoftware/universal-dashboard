import React from 'react';
import M from 'materialize-css';
import styled from 'styled-components';

const Modal = styled.div`
    height: ${props => props.height ? props.height + "!important" : "" };
    width: ${props => props.width ? props.width + "!important" : "" };
    background-color: ${props => props.backgroundColor ? props.backgroundColor + "!important" : "" };
    color: ${props => props.fontColor ? props.fontColor + "!important" : "" };
`

const ModalContent = styled.div`
    background-color: ${props => props.backgroundColor ? props.backgroundColor + "!important" : "" };
    color: ${props => props.fontColor ? props.fontColor + "!important" : "" };
`

const ModalFooter = styled.div`
    background-color: ${props => props.backgroundColor ? props.backgroundColor + "!important" : "" };
    color: ${props => props.fontColor ? props.fontColor + "!important" : "" };
`

export default class UdModal extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            bottomSheet: false,
            fixedFooter: false,
            header: null,
            content: null,
            footer: null,
            backgroundColor: null,
            fontColor: null,
            height: null,
            width: null
        }

        this.loading = true;
    }

    componentDidMount() {
        this.openToken = UniversalDashboard.subscribe('modal.open', this.onOpen.bind(this));
        this.closeToken = UniversalDashboard.subscribe('modal.close', this.onClose.bind(this));

        this._instance = M.Modal.init(this.modal, {dismissible: true});
    }

    componentDidUpdate(newProps) {
        if (this.loading) {
            return;
        }

        this._instance.destroy();
        this._instance = M.Modal.init(this.modal, {dismissible: this.state.dismissible});

        this._instance.open();

        this.loading = true;
    }

    onOpen(eventName, props) {
        this.loading = false;
        this.setState(props);
    }

    onClose() {
        this.setState({
            content: null, 
            header: null, 
            footer: null
        });
        this._instance.close();
    }

    componentWillUnmount() {
        this._instance.destroy();

        if (this.openToken != null) {
            UniversalDashboard.unsubscribe(this.openToken);
        }

        if (this.closeToken != null) {
            UniversalDashboard.unsubscribe(this.closeToken);
        }
    }

    render() {
        var className = "modal ud-modal";
        if (this.state.bottomSheet) {
            className += " bottom-sheet"
        }
        if (this.state.fixedFooter) {
            className += " modal-fixed-footer"
        }

        var header = null;
        if (this.state.header != null) {
            header = UniversalDashboard.renderComponent(this.state.header);
        }

        var content = null;
        if (this.state.content != null) {
            content = UniversalDashboard.renderComponent(this.state.content);
        }

        var footer = null;
        if (this.state.footer != null) {
            footer = UniversalDashboard.renderComponent(this.state.footer);
        }

        return (
                <Modal className={className} 
                    height={this.state.height}
                    width={this.state.width}
                    backgroundColor={this.state.backgroundColor}
                    fontColor={this.state.fontColor}
                    ref={modal => this.modal = modal} 
                    >
                    <ModalContent className="modal-content" 
                        backgroundColor={this.state.backgroundColor}
                        fontColor={this.state.fontColor}
                    >
                        {header}
                        {content}
                    </ModalContent>
                    {
                        footer ? <ModalFooter className="modal-footer"
                            backgroundColor={this.state.backgroundColor}
                            fontColor={this.state.fontColor}
                        >
                            {footer}
                        </ModalFooter> : <React.Fragment/>
                    }

                </Modal>
        )
    }
}