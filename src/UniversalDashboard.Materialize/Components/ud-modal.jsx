import React from 'react';

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
            fontColor: null
        }

        this.loading = true;
    }

    componentDidMount() {
        this.openToken = UniversalDashboard.subscribe('modal.open', this.onOpen.bind(this));
        this.closeToken = UniversalDashboard.subscribe('modal.close', this.onClose.bind(this));
    }

    componentDidUpdate() {
        if (this.loading) {
            return;
        }

        $(this.modal).modal({
            opacity: this.state.opacity,
            dismissible: this.state.dismissible
        });
        $(this.modal).modal('open');

        this.loading = true;
    }

    onOpen(eventName, props) {
        this.loading = false;
        this.setState(props);
    }

    onClose() {
        $(this.modal).modal('close');
    }

    componentWillUnmount() {
        if (this.openToken != null) {
            UniversalDashboard.unsubscribe(this.openToken);
        }

        if (this.closeToken != null) {
            UniversalDashboard.unsubscribe(this.closeToken);
        }
    }

    render() {
        var className = "modal";
        if (this.state.bottomSheet) {
            className += " bottom-sheet"
        }
        if (this.state.fixedFooter) {
            className += " modal-fixed-footer"
        }

        var header = null;
        if (this.state.header != null) {
            header = this.state.header.map(x => UniversalDashboard.renderComponent(x));
        }

        var content = null;
        if (this.state.content != null) {
            content = this.state.content.map(x => UniversalDashboard.renderComponent(x));
        }

        var footer = null;
        if (this.state.footer != null) {
            if (this.state.footer.map) {
                footer = this.state.footer.map(x => UniversalDashboard.renderComponent(x));
            }
            else {
                footer = UniversalDashboard.renderComponent(this.state.footer);
            }
        }

        return (
            <div className={className} ref={modal => this.modal = modal} style={{color: this.state.fontColor, backgroundColor: this.state.backgroundColor}}>
              <div className="modal-content">
                {header}
                {content}
              </div>
              <div class="modal-footer">
              {footer}
              </div>
            </div>
        )
    }
}