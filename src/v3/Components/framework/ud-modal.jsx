import React, {useEffect, useState} from 'react';

import Dialog from '@material-ui/core/Dialog';
import DialogTitle from '@material-ui/core/DialogTitle';
import DialogContent from '@material-ui/core/DialogContent';
import DialogActions from '@material-ui/core/DialogActions';

export default function Modal(props) {

    const [openToken, setOpenToken] = useState();
    const [closeToken, setCloseToken] = useState();
    const [open, setOpen] = useState(false);
    const [modalOptions, setModalOptions] = useState({});

    useEffect(() => {
        setOpenToken(UniversalDashboard.subscribe('modal.open', (x, props) => {
            setModalOptions(props);
            setOpen(true);
        }));

        setCloseToken(UniversalDashboard.subscribe('modal.close', () => {
            setOpen(false);
            setModalOptions({});
        }));

        return () => {
            UniversalDashboard.unsubscribe(openToken);
            UniversalDashboard.unsubscribe(closeToken);
        }
      }, [true]);

    var header = null;
    if (modalOptions.header != null) {
        header = <DialogTitle id="customized-dialog-title" onClose={() => setOpen(false)}>
            {UniversalDashboard.renderComponent(modalOptions.header)}
        </DialogTitle>
    }

    var content = null;
    if (modalOptions.content != null) {
        content = <DialogContent dividers>
            {UniversalDashboard.renderComponent(modalOptions.content)}
        </DialogContent>
    }

    var footer = null;
    if (modalOptions.footer != null) {
        footer = <DialogActions>{UniversalDashboard.renderComponent(modalOptions.footer)}</DialogActions>
    }

    return (
        <Dialog aria-labelledby="customized-dialog-title" open={open} onBackdropClick={() => modalOptions.dismissible && setOpen(false)} maxWidth={modalOptions.maxWidth} fullScreen={modalOptions.fullScreen} fullWidth={modalOptions.fullWidth}>
            {header}
            {content}
            {footer}
        </Dialog>
    )
} 