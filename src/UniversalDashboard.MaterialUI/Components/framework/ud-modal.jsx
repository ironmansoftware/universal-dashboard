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
        header = modalOptions.header.map(x => UniversalDashboard.renderComponent(x));
    }

    var content = null;
    if (modalOptions.content != null) {
        content = modalOptions.content.map(x => UniversalDashboard.renderComponent(x));
    }

    var footer = null;
    if (modalOptions.footer != null) {
        if (modalOptions.footer.map) {
            footer = modalOptions.footer.map(x => UniversalDashboard.renderComponent(x));
        }
        else {
            footer = UniversalDashboard.renderComponent(modalOptions.footer);
        }
    }

    return (
        <Dialog aria-labelledby="customized-dialog-title" open={open} onBackdropClick={() => setOpen(false)}>
            <DialogTitle id="customized-dialog-title" onClose={() => setOpen(false)}>
                {header}
            </DialogTitle>
            <DialogContent dividers>
                {content}
            </DialogContent>
            <DialogActions>
                {footer}
            </DialogActions>
        </Dialog>
    )
} 