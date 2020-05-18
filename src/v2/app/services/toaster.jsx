import iziToast from 'izitoast/dist/js/iziToast.min.js'
import 'izitoast/dist/css/iziToast.min.css';

const toaster = {
    show: (model) => {
        iziToast.show(model);
    },
    hide: (id) => {
        var toast = document.querySelector('#' + id);
        iziToast.hide({}, toast);
    },
    info: (model) => {
        iziToast.info(model);
    },
    success: (model) => {
        iziToast.success(model);
    },
    warning: (model) => {
        iziToast.warning(model);
    },
    error: (model) => {
        iziToast.error(model);
    }
}

export default toaster;