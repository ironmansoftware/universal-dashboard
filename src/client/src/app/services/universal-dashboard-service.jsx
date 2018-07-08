import { fetchGet, fetchPost } from './fetch-service.jsx';
import renderComponent from './render-service.jsx'

export const UniversalDashboardService = {
    loadPlugins: () => {return []},
    plugins: [],
    get: fetchGet,
    post: fetchPost,
    renderComponent: renderComponent,
    webSocket: null
}