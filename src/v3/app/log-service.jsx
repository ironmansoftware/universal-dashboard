import {fetchPost} from './services/fetch-service.jsx';

function Log(component, level, message) {
    fetchPost(`/log/${component}/${level}`, {message: message})
}

export function LogDebug(component, message) {
    Log(component, "debug", message);
}

export function LogError(component, message) {
    Log(component, "error", message);
}

export function LogInfo(component, message) {
    Log(component, "info", message);
}