import {getApiPath} from 'config'

export const fetchGet = function(url, success, history) {
    fetch(getApiPath() + url, {
        credentials: 'include'
    })
    .then(function(response){
        if (response.status === 401 && history) {
            history.push("/login");
            throw new Error('Redirecting to login');
        } else if (response.status === 200) {
            return response.json();
        } else {
            throw new Error(response.statusText);
        }
    })
    .then(success)
    .catch(function(e) {
        console.log(e)
    });
}

export const fetchPost = function(url, data, success) {
    if (!success) {
        success = () => {}
    }

    fetch(getApiPath() + url, {
        method: 'post',
        headers: {
          'Accept': 'application/json, text/plain, */*',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data),
        credentials: 'include'
      })
      .then(function(response){
        var next = true;
        window.UniversalDashboard.plugins.forEach(plugin => {
            if (plugin.responseMiddleware == null || !next) return;
            next = plugin.responseMiddleware(response, history);
        });

        if (!next) {
            return;
        }

        if (response.status === 200) {
            return response.json();
        } else {
            throw new Error(response.statusText);
        }
    })
    .then(success)
    .catch(function(e) {
        console.log(e)
    });
}

export const fetchPostRaw = function(url, data, success) {
    if (!success) {
        success = () => {}
    }

    fetch(getApiPath() + url, {
        method: 'post',
        headers: {
          'Accept': 'application/json, text/plain, */*',
          'Content-Type': 'text/plain'
        },
        body: data,
        credentials: 'include'
      })
      .then(function(response){
        var next = true;
        window.UniversalDashboard.plugins.forEach(plugin => {
            if (plugin.responseMiddleware == null || !next) return;
            next = plugin.responseMiddleware(response, history);
        });

        if (!next) {
            return;
        }

        if (response.status === 200) {
            return response.text();
        } else {
            throw new Error(response.statusText);
        }
    })
    .then(success)
    .catch(function(e) {
        console.log(e)
    });
}